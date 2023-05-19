Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF467099E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjESOec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjESOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:34:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C251B3;
        Fri, 19 May 2023 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684506838; i=deller@gmx.de;
        bh=w7YcoaOaP2N+PmbApERP+wrQNejz5mO0AaxhtqBD/Ao=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gmWgCQofgv7RF/MilB/+J+UCAJBKwzF8rtN/15cMbENhIQWIXE8SDt0WkZ9p3HIz4
         0EAYWrorwtchZcDiGkL+pvqTsKbB/iKCxnFh9XuN558DFAk/leoe061aBsJpPCjwAB
         Comrgpy5l0NqhPEP17kwLH9nAdFa19MAc968hxaGzBa4uRynqMT5GLFzuu/3ikBDj4
         l2XNg/Z9LNpXszquS4bwoVdeh1gww3WxUXf8lYCUJhoJVAnNfHfI2lyvKCR7s+k8eX
         q3oyWBcaykGguRlkqjlaiPH6ChQzwmifspt9FAENZ0wye8NX9MNJsYH48apfI/5HT/
         QOcutxVNRhshw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.232]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1qGS4A0EVA-00s8ic; Fri, 19
 May 2023 16:33:58 +0200
Message-ID: <76a47786-f1e5-80d8-807d-1ab6fa02ebf3@gmx.de>
Date:   Fri, 19 May 2023 16:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] fbdev: i810: include i810_main.h in i810_dvt.c
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230516202814.561262-1-arnd@kernel.org>
 <87lehngxbr.fsf@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <87lehngxbr.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sMvSrVoGkC+EFAh0XcLJmR+jt1VRufyMEAEA8KP+Z4hYvqiNNjW
 c1Rz3EhgDf607LznAh4fD31eR/ITGWz/DRitjr3Ssz/HSWtt4XiqV9ObyhhmWgWC73FpUTq
 uxak5H4vzPdNn3+H76SF4B04XVL/OzLdW3dLPVQLB92KD4ecE30TqtK6XVl5HP+fDSxyVWB
 GevsrpwavzH/FYvIsAs5A==
UI-OutboundReport: notjunk:1;M01:P0:ZtCenKypFwE=;0mS62XZeXZOrgQSTNbQXrL7nRxm
 Ciafs2dOZQTAORGhafcMiyIcR1cTMe5VfWrP8fN4uxpWwtvydip7LLEy2ufOIzZibXDgXIFLD
 F/iJd7HlkMkLhuYIMDLRLQRpPSJ1Vo+QetQBANmiKHzChpjdOwWG8El3TqvbI+7dPhwbtbbYu
 vbWDscGc6v60REC823k0cwLFXnatWxbeIi55icTNoyMUhYCXtmH483xcrJZCofp8rtzTCx6ue
 kz4OHJSlrfkaLhGz44OEpUAxSjLAyEATKk7vavoh+AafuTFpBHdsAmQXWGCx3zXFpjM9jndYK
 g0SFbUEYKnbS02spYIrtY8LGeELPY28FFbzBYUxwZBhx/NPLg1PIUDZ2b1FvpZCxOJWifR6lK
 UBwkjRPe5q8QOjH6VJojh2eT4Pp4CsbmxUJT21TIQJwhhGxdrpVmiN6G2ELttdE5fvu7NsebL
 CdeYdEtK7IkNyrvKPMESH5P0kk84kbkwo4Ogx0cCTWUcpBpFmZQ1CWtdJOr7ythlYtGksIoCg
 Z9KoNN3cAdaULf+hwEdYOlgHnM9wIpyE0p92xNHgkecNfz6sSjDibewfsAHbjil+MzNCsc/ms
 GcT7r9FGwqcLjgPGR3ZB+LElXc+C/e8hhrTpDje1ZQhJg+hGsE4EeDFzlW9Pu1OES+qlZsJVy
 OQOZ0XsuVZvSHDl1eN2w+NtkdtGxLq4QvFl0BD/Fymr1G1DydUOQ7Q6xnIejDBS1dMt2malph
 nJ21Majmp9qFmQ1zVMF1rtGtmqQhyIgMbTUtzC8d6GHSs7JPKacIn81506HRa9b9s+EH1y1KM
 YhU0B5cfv5bCyAlqgPDctDHQn2U8WMnn+eN9QzpUIRMrDJE9AZH0SMWilqSShK/M8S5l1Ozsc
 D3U2O2NfsNmdsJFzuFbEKvICAbMHicRgXrk8geIVzG6NbPYOM0cLwscWtEVGoo6+/jnYJQbZO
 m7jQNWJuBtYTlDIQMz3oXLcUV0s=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 10:46, Jani Nikula wrote:
> On Tue, 16 May 2023, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Building with W=3D1 shows that a header needs to be included to
>> make the prototypes visible:
>>
>> drivers/video/fbdev/i810/i810_dvt.c:194:6: error: no previous prototype=
 for 'round_off_xres' [-Werror=3Dmissing-prototypes]
>> drivers/video/fbdev/i810/i810_dvt.c:233:6: error: no previous prototype=
 for 'i810fb_encode_registers' [-Werror=3Dmissing-prototypes]
>> drivers/video/fbdev/i810/i810_dvt.c:245:6: error: no previous prototype=
 for 'i810fb_fill_var_timings' [-Werror=3Dmissing-prototypes]
>> drivers/video/fbdev/i810/i810_dvt.c:279:5: error: no previous prototype=
 for 'i810_get_watermark' [-Werror=3Dmissing-prototypes]
>>
>> Adding the header leads to another warning from a mismatched
>> prototype, so fix this as well:
>>
>> drivers/video/fbdev/i810/i810_dvt.c:280:5: error: conflicting types for=
 'i810_get_watermark'; have 'u32(struct fb_var_screeninfo *,
>
> Changes here look fine,
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

applied to fbdev tree.

Thanks!
Helge
