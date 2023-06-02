Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5EF71FC78
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjFBIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjFBIsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:48:19 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1AB1737
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:47:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230602084730euoutp01eb40bb27d10bb1f6944cc90cb027f8b3~ky0NGNSbX1068110681euoutp01F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230602084730euoutp01eb40bb27d10bb1f6944cc90cb027f8b3~ky0NGNSbX1068110681euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685695650;
        bh=vifMgSmablSJYtcBsnJzPn7Ul7wbzd0xbOWiVjKaYqQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=VgrX91JQm2aNpr78FchK6/KNuxp6IESPkGBBSo8fwGgUmml+chw3EzJ5z+/+c1x14
         t+kDv4efhpx1jR6wkT9ilU3j2Fa3qFJPlKq8VM30XO32ZddlZZHUonS8nEdepIDsg/
         3nhI7GI8qtXW8Z0GxmbJFEUTOTe0IezAgukEFUKU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230602084730eucas1p1b93d3e14361d7b02f4b79c87b1d56344~ky0M8THCi0628406284eucas1p1l;
        Fri,  2 Jun 2023 08:47:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.45.37758.2ACA9746; Fri,  2
        Jun 2023 09:47:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230602084729eucas1p21d572cc0c2cfa671c1c5668beca53ae8~ky0MjgsIW1432714327eucas1p2y;
        Fri,  2 Jun 2023 08:47:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230602084729eusmtrp222adcd926bfc53e3c575b6928f24dbae~ky0Mi2Tuy0464204642eusmtrp2T;
        Fri,  2 Jun 2023 08:47:29 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-3c-6479aca289ae
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.95.10549.1ACA9746; Fri,  2
        Jun 2023 09:47:29 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602084729eusmtip192a8de50f9973961360bb45f5fbe5456~ky0MJUEUB1505415054eusmtip1L;
        Fri,  2 Jun 2023 08:47:29 +0000 (GMT)
Message-ID: <428e37b4-7fb6-7026-8ad9-91218b034a12@samsung.com>
Date:   Fri, 2 Jun 2023 10:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] Bluetooth: hci_bcm: do not mark valid bd_addr as
 invalid
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230602081912.4708-1-johan+linaro@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7qL1lSmGCxsYrdYUWmxa+oxZos5
        1/qYLS7vmsNm8fTzFFaLb59+MVp83vCY0YHdY3bDRRaPnbPusnus372c3WPTqk42j8+b5AJY
        o7hsUlJzMstSi/TtErgyZq1+wVqwkq/iy5SFTA2Mv7i7GDk5JARMJO5vOMjaxcjFISSwglHi
        9crtbBDOF0aJ7SsvMUE4nxkljmxewAjTsuN1PztEYjmjxOf9/SwQzkdGie4Fx1hBqngF7CSu
        Xe5iA7FZBFQk/i14yA4RF5Q4OfMJC4gtKpAq8W3uDqB6Dg5hAX+JMz+8QMLMAuISt57MZwKx
        RQTWMkocXqINEc+UOHJ8PTOIzSZgKNH1FmI8p4CNxNf1X1ghauQltr+dwwxyj4TADQ6J6cdm
        QV3tIvFp+xVWCFtY4tXxLewQtozE/53zmSAa2hklFvy+D+VMYJRoeH4Lqtta4s65X2wglzIL
        aEqs36UPEXaUeP6zjRkkLCHAJ3HjrSDEEXwSk7ZNhwrzSnS0CUFUq0nMOr4Obu3BC5eYJzAq
        zUIKlVlI3p+F5J1ZCHsXMLKsYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECExAp/8d/7qD
        ccWrj3qHGJk4GA8xSnAwK4nwCoWVpwjxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5Y
        kpqdmlqQWgSTZeLglGpgYth9qG9mtCzDq5CPNxUEZz4w0bxjcPWuh8Fv9WcyQt83W6XH6h3x
        Sr6xSL130wUp/SkeFsI9Cl1JSyv5VLe8XcVVJTU1LWmX+E0jm9lL5LZdUThX/XziT7W3XItO
        zlK1m+Fu+EZ9Mu95Y653pdPqYk48EGa2599yhXl/weue5RGeW9YavC3X6JyeYXA2Zcsvo/eh
        rxc+n7BsUi6bR9B1Lqmb+7mKt4h1rZx6hD+2V7nPdfvCFsUDfK91HirMZs5d7v9BSCh2ymqH
        jUsmr3LZtfl6W7Kfsdbnx5e78uboLwqObxLdcLA2UKajyrnZZpF+7/X662svqpst3PHJac2a
        Z9lNu3iOp7aGvki/+4ojRImlOCPRUIu5qDgRAJKfjaavAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7oL11SmGFx4pWmxotJi19RjzBZz
        rvUxW1zeNYfN4unnKawW3z79YrT4vOExowO7x+yGiyweO2fdZfdYv3s5u8emVZ1sHp83yQWw
        RunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlzFr9
        grVgJV/FlykLmRoYf3F3MXJySAiYSOx43c/excjFISSwlFHi4svtjBAJGYmT0xpYIWxhiT/X
        utggit4zSvx+vIEJJMErYCdx7TJIgpODRUBF4t+Ch+wQcUGJkzOfsIDYogKpEr1fVoANFRbw
        lZj/fiZYPbOAuMStJ/OZQIaKCKxnlFj07S1QAwdQIlPicoc2xLJ+RokPDZfAGtgEDCW63kIs
        4xSwkfi6/gsrxCAzia6tXYwQtrzE9rdzmCcwCs1CcscsJPtmIWmZhaRlASPLKkaR1NLi3PTc
        YkO94sTc4tK8dL3k/NxNjMCY23bs5+YdjPNefdQ7xMjEwXiIUYKDWUmEVyisPEWINyWxsiq1
        KD++qDQntfgQoykwMCYyS4km5wOjPq8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1
        ILUIpo+Jg1OqgSl/5R+uHQKJ8lnaLw8oiHazXBM9tbmz+/yZM3vjL4T67rhUn//OyOVgqlWE
        Uq673CGdDWyvkhJ6H7888Zqj8t0sP+kXM/TO8jzQiHYTYJCbf12jSfz1Ba6vZjPUZgf17V7p
        V2T7TPhD2L+YLO0Q5jdbz68wZxIO2lXXonvBt+TavdCv3+Ym3/k5e2uH2aJ9cWZS5i+bdtw/
        3Wr67O+LjMRD5TIS/jIVDstt758q2cEo5Lxh5haTh02Zie+ddxxJcV7B9922L/j11NavvnHa
        04Kqrsioli76ar+kuYa16i2HREjS3Fm/b8Z+mbLO0aOofmagXEjgQpZ2ocRND3RXX81MmvNk
        79Gq3TkWmsI8zEosxRmJhlrMRcWJANzn0pFCAwAA
X-CMS-MailID: 20230602084729eucas1p21d572cc0c2cfa671c1c5668beca53ae8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230602081950eucas1p22a82f91f361fb64e23ecddada3173534
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602081950eucas1p22a82f91f361fb64e23ecddada3173534
References: <CGME20230602081950eucas1p22a82f91f361fb64e23ecddada3173534@eucas1p2.samsung.com>
        <20230602081912.4708-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.2023 10:19, Johan Hovold wrote:
> A recent commit restored the original (and still documented) semantics
> for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device address
> is considered invalid unless an address is provided by firmware.
>
> This specifically means that this flag must only be set for devices with
> invalid addresses, but the Broadcom driver has so far been setting this
> flag unconditionally.
>
> Fortunately the driver already checks for invalid addresses during setup
> and sets the HCI_QUIRK_INVALID_BDADDR flag. Use this flag to indicate
> when the address can be overridden by firmware (long term, this should
> probably just always be allowed).
>
> Fixes: 6ac517d8cf8b ("Bluetooth: fix use-bdaddr-property quirk")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/lkml/ecef83c8-497f-4011-607b-a63c24764867@samsung.com
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/bluetooth/hci_bcm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 83bf5d4330c4..874d23089b39 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -643,7 +643,8 @@ static int bcm_setup(struct hci_uart *hu)
>   	 * Allow the bootloader to set a valid address through the
>   	 * device tree.
>   	 */
> -	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
> +	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks))
> +		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
>   
>   	if (!bcm_request_irq(bcm))
>   		err = bcm_setup_sleep(hu);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

