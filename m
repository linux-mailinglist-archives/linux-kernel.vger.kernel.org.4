Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0560471F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJSNai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiJSNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540091FF8D;
        Wed, 19 Oct 2022 06:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C03E861889;
        Wed, 19 Oct 2022 13:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CB8C433C1;
        Wed, 19 Oct 2022 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666185359;
        bh=pY5TUB/6IlNSwyBWrO9lqOljFr0jiKToNLZXhibz+C4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a16lRnhE4AxisAaExKttajlfHCwytQPBcg9Bhyyi/cED8dcdLVtowwbiNXUcijgNC
         +YlMyFSbSYZXhvsLuIhl/J0fmqCBahLxAooQEJ8DAlfb9vbOK9Dp/nzmoGFtXCWZiS
         A7S0s8OE1TW3DllaqG7XAjrNaHtNIPkZzReN2pujwtm2YQ+EEU9WYkaL9D+w8xzh6s
         TTrxW3kE8Bf1aqDN5P2s47AEdGItFUvqezuU2gu9jmoPGRAyd1zsR5YunbWrVEEfhN
         vR/ICkY0bsM3by0dqwY90nmaXE2OC33/Mc4d9v63Ln896lVmgc3QL3menVAtLzATvx
         VHV/puX0EQu3A==
Message-ID: <73cbfbaf-9397-00ab-4844-e5dd96958912@kernel.org>
Date:   Wed, 19 Oct 2022 15:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] rv/dot2c: Make automaton definition static
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <ffbb92010f643307766c9307fd42f416e5b85fa0.1661266564.git.bristot@kernel.org>
 <20221018182553.06f13a50@gandalf.local.home>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221018182553.06f13a50@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 00:25, Steven Rostedt wrote:
> On Tue, 23 Aug 2022 17:20:28 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> Monitor's automata definition is only used locally, so make dot2c generate
>> a static definition.
>>
>> Link: https://lore.kernel.org/all/202208210332.gtHXje45-lkp@intel.com
>> Link: https://lore.kernel.org/all/202208210358.6HH3OrVs-lkp@intel.com
>>
> Somehow this fell through the cracks.
> 
> Daniel, is there any reason I shouldn't pull this in now?

Oops... yes, it can be pulled.

-- Daniel
