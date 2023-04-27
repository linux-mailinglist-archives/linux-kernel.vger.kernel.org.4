Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D386F0521
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbjD0LrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbjD0LrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:47:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB6E4EFB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:47:12 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MO9r5-1pcpoc48xF-00OWDH; Thu, 27 Apr 2023 13:47:04 +0200
Message-ID: <7e89c6ea-3ea0-bbd7-1261-9ca687e4d09d@i2se.com>
Date:   Thu, 27 Apr 2023 13:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression: w1_therm: sysfs w1_slave sometimes report 85 degrees
 Celsius
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akira Shimahara <akira215corp@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        regressions@lists.linux.dev
References: <b1093de5-9f62-6714-0063-7c719dc4f6ca@i2se.com>
 <2023042645-attentive-amends-7b0b@gregkh>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <2023042645-attentive-amends-7b0b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DywFAflWM0RArQGlZHMeRccCQPE695q/C0HyS5erfKRh7g0cAyp
 UndXvZym9ujBvdG1o+8SlYHVdsumnlCMDGSdCZGXbQzkREDKGki1Q2fOQ1nS6Ck3bzZ1nCn
 tvXPtkDRBf/cPz3ciNGMM4zdPS68tp/I0dvLanOwgHNW8f8Yfcr51pmRk6zroFMOhgFy6sY
 tgSrTJ3/1PkqmcJkum77w==
UI-OutboundReport: notjunk:1;M01:P0:FYdSZXaX/kU=;MpA4uryXMae2Sv1ywSY2DHF5TPj
 lXPcUJS2fnjHk/iHSl9mvngxpgsoGPWCEsIZYJu26fo2I5xgcLPflUy0R6vjhs8JgpT1afSqo
 07PGALW4TVB9wgjWohSOxdmnYLGlMzgaici0mBwFKWMSnoCezwutYeo/sEhBqwHkcDxw3Yus+
 d32SoqTzl6jxIgiBHj4E1AnB4DsRqlhqeVEAsDYD3BFyPDKWG6vl/gI37kxtpmHne//fa1Jxn
 NZVYvZZ3oTV88QLo9QsqYd6bo0HHjpAE1AeC8jmhzrnQX1y0dv5Sd3YUxHUBRiELe/qFr0iDt
 4FgBVbITq7wBCGQpAP3DJP+QJGVJwfnWuEvV17srJRbICMNV6F4+TD0v2uqyVT8v29EN/SBOZ
 4U1UGDkU3ew03P5688G3PRSnvomCZD+Zh3d4FeSvbhhDR5QFc5tlfaMH1KK3GILUMwuxHzj2R
 HLyD1UzstsoIGHWTK064wK/t36hzJlEVzp0C0RcDcjP8N54OlFpgD+eTK0CmVv7/FEoHuqbd4
 2ZyR8dnS4p0TCTermP8K/Z5pdu0kuzxFzMow2dyi+Ly2QnYvGaumNWYzHPKr9R6j3ph2icO/Q
 PJoWSgaSj5K8O2NdnanmBJVZKZ7B0B3OWb7biso4ElaUYD5PnZMlH+nSSd6L7rEUg2UbiBxKu
 kBeS4MU6PdBHaYl7iWjuWuRIWH+aSCenXwBurOfiew==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you send a patch that shows the change you wish to have made here so
> that you can get credit for fixing the issue?

Sure, just for reference:

https://lore.kernel.org/lkml/20230427112152.12313-1-stefan.wahren@i2se.com/T/

> 
> thanks,
> 
> greg k-h
