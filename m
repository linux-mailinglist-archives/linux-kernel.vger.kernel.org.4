Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2992653ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiLVLMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiLVLMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:12:43 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FD12600;
        Thu, 22 Dec 2022 03:12:42 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1Ofr-1ol6Fn41X9-012oX5; Thu, 22 Dec 2022 12:12:25 +0100
Message-ID: <506d3ae3-f06c-1243-877b-d1378bf435c6@i2se.com>
Date:   Thu, 22 Dec 2022 12:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/7] staging: vc04_services: Remove custom return
 values
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221219115725.11992-1-umang.jain@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221219115725.11992-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+LrVFEaSYMKMoobIImZxGzMr/IVa7WJwJFMqcGxKpjqDgtN/jDp
 +ArrR4OPw3h01RdHC/lXodT/EkO7TCZQ1UhdbqqfPm6w0axl+z/kncUZOu7TDdKMyA1Zvuk
 Nl9sOIgXBwnHTZDu7sC1+P6Kw1CkFU9ymlXEKhHT8Tv3ia/ONyK9sJFBIgF3tdf8INketzG
 FvihpZOYsaz6I/7+DZKvg==
UI-OutboundReport: notjunk:1;M01:P0:yhPsEOh5kHU=;s9Cz3HF4r3OSITv04JbS2Gsbgd9
 vUe/JjBud2Y9iqXus/8qJOT4oZzGoSjHWFrBdszLdqkOiPuR+lGrabAQZvTc0f23Np1VNP4wF
 +Ct82RjTDL93iyOYk6RfIF8jrtoI0hAPJv1Cmw7lONj1rd3asNtfCzxTNjgsvoMXzBZ0ZR+Ki
 i+1Uy2aB474C6RWnRVnhiNTUDruGL8jSf51jLhfUyvMZUGjXUYOjDRhSw8nIxcVCth+gdkLK5
 zhAcrbX5T8ZVr9JXqq+mFc14/BRKOac4waZpWbUsUL/2zIdRcqYkzibU9V3y8NP5aDGM7FH7R
 JY9+Nf339NZaGT/DYq7xb4K694Tnu3LvXWJJRfemQ5ur1XvLhgncks9l678OHxxIVjn7wYf77
 Epx8t1+YjLAZIsbX/aTob2l3/OfDTODxL0slqS9fWoNLInv7baIXGk7PLQYr2pjnW657y+11u
 fmeG+hs8BrtU3Tgf/LP6Aind1rwaOKLhCGxGL+AxR9DBWLhufrG50JlNiG89blHTVsBRwGDcc
 gvSjYG6dPpx2VlOfmzy+q3GmNtHtnf2i7Rz/1OauMydWhO5TVeO4gpr4gPqdCIj1VoahJkxoh
 sjyRROX87l/GCn3DwqXz+HjXNlzukl/KGGD/f0UNwPUXoCY/DESl4sSdVvbA1tITFhdprB+P0
 TrjP72byrtGEVpMS+LYuoC82Il4oe8jRA6JmZLZwow==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.12.22 um 12:57 schrieb Umang Jain:
> The series removes the custom return values from functions
> and replaces them with linux error codes. This address the TODO
>   vchiq interface:
> * Get rid of custom function return values
>
> Changes in V2:
> - Patch 3/7 now reports for specific errors like -ENOMEM, -EHOSTDOWN
> - Patch 5/7 reports -ENOTCONN instead of -EINVAL and adds a "Fixes" tag
>
> Umang Jain (7):
>    staging: vc04_services: Replace vchiq_status return type to int
>    staging: vc04_services: Drop VCHIQ_SUCCESS usage
>    staging: vc04_services: Drop VCHIQ_ERROR usage
>    staging: vc04_services: Drop VCHIQ_RETRY usage
>    vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage on disconnect
>    staging: vc04_services: Drop enum vchiq_status remnants
>    staging: vc04_services: vchiq: Drop custom return values from TODO

The whole series is:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

