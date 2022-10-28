Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7677D611E33
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ1XkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJ1Xj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B505C26AE1;
        Fri, 28 Oct 2022 16:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C69462AE5;
        Fri, 28 Oct 2022 23:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8531EC433B5;
        Fri, 28 Oct 2022 23:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667000395;
        bh=ciFSuPtgT3cSHLoMyRMs7see4cx+g19cnMj9AnGPTQ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fj/7mfsC4icsTslOzCKhiOvHv+Qx6k3uK+Lpc8qqDQQybdO25Z9JeStYwatYpAGGv
         2uGeq4FRg8cgCLhyMjabVrDmfVE0Pk53GKxjVTRHrSOhMOwXQF/7x+Y4VjM8VYsuuv
         lhsTR0xO6VncQxxChotEL/2sj2lZDvFBjmR6W6GLtyKWx64E3UTE43BoPsc1IfxUhe
         M4SFnr7cCGZSW/5Ax+fhP13oLgi8qISvoV5x13DEl6Q1rg2Vzo4dT+w0Y8iRWbNDIo
         zpIlJY61JLnR16c9mIgypnWvHGGQC2x25nsjZGTQ0RYkPLfjVhpiCMGAPS2t9FyBEz
         UeRB2KjRqVgbA==
Message-ID: <7ef6e7a0-add8-3c92-f174-82f1561fccea@kernel.org>
Date:   Fri, 28 Oct 2022 19:39:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v10 6/7] dt-bindings: media: wave5: add yaml devicetree
 bindings
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
 <20221022000506.221933-7-sebastian.fricke@collabora.com>
 <20221023085341.s23qinjuw4qls3dn@basti-XPS-13-9310>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221023085341.s23qinjuw4qls3dn@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 04:53, Sebastian Fricke wrote:
> Hey all,
> 
> I have noticed that I renamed the file incorrectly, in V11 it will be
> called: "cnm,wave5.yml"
> 

When resending be sure you cced proper people... You miss here a lot so
this clearly is not the process.

Best regards,
Krzysztof

