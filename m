Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E66F632FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiKUWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiKUWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:21:19 -0500
Received: from smtpdh18-2.aruba.it (smtpdh18-2.aruba.it [62.149.155.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D4723163
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:21:18 -0800 (PST)
Received: from [192.168.50.220] ([146.241.87.80])
        by Aruba Outgoing Smtp  with ESMTPSA
        id xFACot2il4DZxxFACoR1hz; Mon, 21 Nov 2022 23:21:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1669069277; bh=1UZ/C/tsYgnj+8Q8AodJYSvWklcS1vn0kQ7LQxz3AL0=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=ZOmWwjXcEHgNancvSWOAXIyUj+t/V1vzkuTwHCL6HbHFoI8ce81qboL4purpmaDX0
         j0tE1cdJBtwWBYXHwnMERJgm77TMNfEP8+Exc9IdvXRcHtQh7imkh4Z4WOgLnx2/jZ
         7B7uRiqWASTsbA7II5yEB4EcK3EiHpzqb5xmcBwCIjodgiFxvpmZ5Q3QrCt4EWItIZ
         Ea82/0D81t07Gg5o5iX9ug0PusJjt4P6O8vlsti3c3tJOhZzsykli404Wmg+N7vW9b
         Cgghsq2vFDSotT/PNXOBkdm3dRMiy2AtgKTSkRhX/j8rG3F30ess3m3mYFU3jRuAxY
         Sknf9kFlAPYhw==
Message-ID: <d7aede25-b0a9-aad7-10bc-325bd8d5acfa@benettiengineering.com>
Date:   Mon, 21 Nov 2022 23:21:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB
 offsets
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bough Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>
References: <Y3vRjItCVhvCRLv4@linaro.org>
 <7C149D5F-FE43-466E-A02F-2AAF5B31B844@benettiengineering.com>
 <Y3vt94iDv6MHOPDB@linaro.org>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <Y3vt94iDv6MHOPDB@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfN3dByCwMLoz63p3hc2GgpxrneTJJgEdJve9G21C0hU3elsp24VH+T48XDBFZJsd4DTjI+Yeds5NCFs4NrlrYII+AUiVlc3F8SIhspeKI64UW+wVhStn
 lqpKlkPfe2IKWVMgB7GPsuBn62CGTU/Vfxyozb5TJL2ax0nuSry16HKG8d0uGsAhw/QyFzbSFuNjLE6ceOuraRuj1udRyAChGfavpaCUjT+fN2zC8bxIHyAx
 UnJTasTxZSNlsaqQXDDcByvSHmkSnCWutjeS+/18dtq4X3/yQWJAiDQN4gt38ptCXZ83OhNYMCuOhiIiKVdBl+Ma8/gYiS1TGdgB8tNaHB7IbUrbJKdEAtAH
 VbBc1gd66l7ExMXc2v2w6dDtoQKqgOwTnPhcJwj+e2pkLozNgdb9Hkn62fvIpALZhq0jDsqUnKdoGSS2NWMEVkrZ8jVXYO/v9RIMdx933DOGaz9dv1VN0tl2
 yZg2mr5YQ7Hd8gKQqy0Bu49m8YOv0kzxjkop+KYPaH/bJ6y/HyAc69C0MpfR64W/LmCrcIttNHFTX33JWqN+BaNh6DJhU1s1WNGkTsBktrf0T8vCbN06XEmG
 ayA36aLDqJdHYO3Njw1Gl6D+3+HEEBCyU3kDj8G70188fOUVo3z7DEqF6jQTpL/n3iaPCBhiNV+DpBfNHn3ANB8mBtT6HHrMIOKTUIZRVN7/8X07d2oa8213
 eHTtOCu6W3biKz1ZvE+dFuco4ppvJr1rVz+j2nxoOD4VOh2TjWDKhBK02f3OCPSI8V7QIiLmplI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/22 22:30, Abel Vesa wrote:
> On 22-11-21 21:30:06, Giulio Benetti wrote:
>>   ....
> 
> Please, no HTML formatting. Plain text email only.

Oh, I was on my mobile, sorry!

-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas

> So I guess I'll just apply this version then.
> 
> Thanks,
> Abel

