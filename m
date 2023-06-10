Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5D72ADBC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjFJRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjFJRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E13C28;
        Sat, 10 Jun 2023 10:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6043D611A5;
        Sat, 10 Jun 2023 17:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8287AC433D2;
        Sat, 10 Jun 2023 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417930;
        bh=SUXyLetcsujdlo5pQE552oUdGTnYIgJFY687Q3f9Czk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ayx4ORGmpoB6u++xfd8iYOTdlQMqKADWLvxH28w+h4qleg9Pwv5UI+tLUayd9ed/1
         ViwoaSfkMTRGqxRWUB/IPL0GL9HXxr1E++oBO/qDBmErE7+tmxIy1XomNn9BdDCYCg
         hcqY09npfj2xMxiY5BwtH+gw2+dh92e3I4ge2tOmdwLV0lw23xJ1ZpIF5YnS26xx1b
         jM95o49uA3IkYFs9xhiMuvwIWj4Dk+lqfNV0YvUdEOw7BTQs2Wdoyh5GPKuXwrNd5I
         yO6C8YVriec1aNlUdWlDnzfSG7h4w0Per4KuAKArjZ7kY9yreAj9DfVMl3V27gNfxS
         QHj4WidYxmmPA==
Date:   Sat, 10 Jun 2023 18:42:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [dt-schema PATCH] schemas: iio: add label
Message-ID: <20230610184206.4a4c3da8@jic23-huawei>
In-Reply-To: <168624795645.3178290.5235314768802159315.robh@kernel.org>
References: <20230507171219.232216-1-krzk@kernel.org>
        <168624795645.3178290.5235314768802159315.robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 12:13:55 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 07 May 2023 19:12:19 +0200, Krzysztof Kozlowski wrote:
> > Linux IIO core code parses label property which is already used in
> > several IIO devices.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  dtschema/schemas/iio/iio.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >   
> 
> Applied, thanks!
> 

I'm guessing you already know this but I hit it during testing.
dtschema/main + ruamel.yaml 0.17.24 and later seem to be broken. It installs
fine but...

AttributeError: module 'ruamel.yaml' has no attribute 'YAML'                                                                                              
$ /usr/bin/dt-doc-validate                                                                                                  
Traceback (most recent call last):                                                                                                                        
  File "/usr/bin/dt-doc-validate", line 4, in <module>                                                                                                    
    __import__('pkg_resources').run_script('dtschema==2023.5.dev6+g4ddf315.d20230610', 'dt-doc-validate')                                                 
  File "/usr/lib/python3.11/site-packages/pkg_resources/__init__.py", line 720, in run_script                                                             
    self.require(requires)[0].run_script(script_name, ns)                                                                                                 
  File "/usr/lib/python3.11/site-packages/pkg_resources/__init__.py", line 1559, in run_script                                                            
    exec(code, namespace, namespace)                                                                                                                      
  File "/usr/lib/python3.11/site-packages/dtschema-2023.5.dev6+g4ddf315.d20230610-py3.11.egg/EGG-INFO/scripts/dt-doc-validate", line 16, in <module>      
    import dtschema                                                                                                                                       
  File "/usr/lib/python3.11/site-packages/dtschema-2023.5.dev6+g4ddf315.d20230610-py3.11.egg/dtschema/__init__.py", line 1, in <module>                   
    from dtschema.lib import (                                                                                                                            
  File "/usr/lib/python3.11/site-packages/dtschema-2023.5.dev6+g4ddf315.d20230610-py3.11.egg/dtschema/lib.py", line 35, in <module>                       
    rtyaml = ruamel.yaml.YAML(typ='rt')   

I've worked around this by setting a max version at 0.17.
Only change in ruamel.yaml between those is:
https://sourceforge.net/p/ruamel-yaml/code/ci/4309006902d2453399588f4ddccfb3fc460e1eba/

My python is terrible so I'm not looking into this further.

Jonathan
