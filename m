Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF9571F57D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjFAWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFAWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:02:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFD418C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:02:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230601220157euoutp01e948b2ab24d7e583d1c4d6b617b4a015~kqAkFZb-n2943129431euoutp01i
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:01:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230601220157euoutp01e948b2ab24d7e583d1c4d6b617b4a015~kqAkFZb-n2943129431euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685656917;
        bh=3WrzPlGJEtUHzBKCdYc00TeSvSfBzqLWzwawyBbA3wE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=aqCmWAmLskG8ygGerKJvAebj5GGH/XmcRcd/IAkajZGacxD0nENOwAyqE+XoHwzV6
         q3zBp8omBnHxhEEcxIuUnFdFmLr5oVW21k29W7nV6EYDBgkD9uH7oYKKKZBPLrXRNC
         muXcPn7I1ZpUfJSn81ksdBMeX0AnyfPYGzgKPZYI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230601220156eucas1p13086dbb1e50c6b3636b227b01192b79a~kqAjtZP2h2463824638eucas1p10;
        Thu,  1 Jun 2023 22:01:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 11.2A.42423.45519746; Thu,  1
        Jun 2023 23:01:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230601220156eucas1p21caabcf02509fce7eb26f973704980f9~kqAjbK75X2908229082eucas1p2d;
        Thu,  1 Jun 2023 22:01:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230601220156eusmtrp20c88fe638cfc3c841284c69853b6d229~kqAjanaEr1406014060eusmtrp2d;
        Thu,  1 Jun 2023 22:01:56 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-93-647915548c7e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.EA.14344.45519746; Thu,  1
        Jun 2023 23:01:56 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230601220156eusmtip261d66749e5ad25ba0b01fc271cda08ce~kqAjAvrDF2825028250eusmtip2z;
        Thu,  1 Jun 2023 22:01:56 +0000 (GMT)
Message-ID: <ecef83c8-497f-4011-607b-a63c24764867@samsung.com>
Date:   Fri, 2 Jun 2023 00:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230531090424.3187-3-johan+linaro@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7ohopUpBh936FqsqLTYNfUYs8Wc
        a33MFpd3zWGzePp5CqvFt0+/GC0+b3jM6MDuMbvhIovHzll32T3W717O7rFpVSebx+dNcgGs
        UVw2Kak5mWWpRfp2CVwZTXsWMhfskK54ufo2UwPjU7EuRk4OCQETibdL/rJ1MXJxCAmsYJS4
        tmYBM4TzhVGipXc3E4TzmVFi89JbzDAtc5beZoFILGeU6Dl2lRHC+cgo8XPdMhaQKl4BO4mP
        nY9ZQWwWARWJg/dvsULEBSVOznwCViMqkCrxbe4OsLiwgIfEy7NrwGxmAXGJW0/mM4HYIgJr
        GSUOL9GGiGdKHDm+HuwKNgFDia63XWwgNqeAjcTi/21MEDXyEs1bZ0NdeodD4v3nOAjbRWLN
        k4lMELawxKvjW9ghbBmJ/zvng70pIdDOKLHg930oZwKjRMPzW4wQVdYSd879AtrGAbRBU2L9
        Ln2IsKPE/btzmUHCEgJ8EjfeCkLcwCcxadt0qDCvREebEES1msSs4+vg1h68cIl5AqPSLKRQ
        mYXk+1lIvpmFsHcBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwAR0+t/xTzsY5776
        qHeIkYmD8RCjBAezkgivUFh5ihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6Yklqdmp
        qQWpRTBZJg5OqQamKvNenyjbB4a/Lx3xqlx8d67DHeMXiq0JKp80uUq7VHkNz5WWh/ls/Gt0
        LdK9yniq/NEC8SNKB1xzufNWr9jW+iSb4YTV+5uvp60t59HfoFXk9EFig71dv135psuHHu/p
        PKiSXfIm4F0qv8aH56zLdh5S7XTNXta1Y+X9tM3XZ37t9f/SslZ4vdua5n8qgg9uiny8redr
        GHNnRv+P/pWNs3J9Iozrp55ISEtJEkwQXH736iaDJTfVnqbf7Sk5FLS9Ne/y2wleL312WN+4
        HeixbFXhnOnysVMOhNU4q/I35G4Jf3pxtZXgsYebzG39Z9qZpbfNz7QtWfH4rr2gAL//8+V6
        9wyM/dntWSYrxd1SYinOSDTUYi4qTgQA9cCZo68DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7ohopUpBls7ZS1WVFrsmnqM2WLO
        tT5mi8u75rBZPP08hdXi26dfjBafNzxmdGD3mN1wkcVj56y77B7rdy9n99i0qpPN4/MmuQDW
        KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mpj0L
        mQt2SFe8XH2bqYHxqVgXIyeHhICJxJylt1m6GLk4hASWMkoceT2XHSIhI3FyWgMrhC0s8eda
        FxuILSTwnlHi/AlvEJtXwE7iY+djsBoWARWJg/dvsULEBSVOznzCAmKLCqRK9H5ZwQhiCwt4
        SLw8uwashllAXOLWk/lMIItFBNYzSiz69haogQMokSlxuUMbYleuxIJFm5hAbDYBQ4mutxA3
        cArYSCz+38YEMcdMomtrFyOELS/RvHU28wRGoVlIzpiFZN0sJC2zkLQsYGRZxSiSWlqcm55b
        bKRXnJhbXJqXrpecn7uJERhv24793LKDceWrj3qHGJk4GA8xSnAwK4nwCoWVpwjxpiRWVqUW
        5ccXleakFh9iNAWGxURmKdHkfGDE55XEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YW
        pBbB9DFxcEo1MO1LVjUQ3L3z12rm087JKZF33iYcNzIqn3j3HKfks41q5tvP87Y+vdn8Svik
        cU5aqU/DOb6W82ml65+vjfr3Wrb0aeup/dK9M2oy3u/9eD9pyd6HDvMt/FMN/pjkLG5gMZBq
        u6QtfWLy0b9rziRNj34sUcB0Qnxda33N2209TwPq5BlUdGIC27+sy5926NAuwwdPnAStzIJm
        LA2axvWPvWv9/H3qijtc928oLBT/7Lh34cuNudfk/6vu+T733TG/wz6eXAadu3xOHHxn9JLf
        ++zdNTJCR31nXDv2W3iudHzOuSlil2vYeO7vDT6ZaPmlQlThSiTXtKehbqoXru7QF5q09Fnz
        Ma3IujduOfGr+xyVWIozEg21mIuKEwG8+g2VQAMAAA==
X-CMS-MailID: 20230601220156eucas1p21caabcf02509fce7eb26f973704980f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230601220156eucas1p21caabcf02509fce7eb26f973704980f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230601220156eucas1p21caabcf02509fce7eb26f973704980f9
References: <20230531090424.3187-1-johan+linaro@kernel.org>
        <20230531090424.3187-3-johan+linaro@kernel.org>
        <CGME20230601220156eucas1p21caabcf02509fce7eb26f973704980f9@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2023 11:04, Johan Hovold wrote:
> Devices that lack persistent storage for the device address can indicate
> this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controller
> to be marked as unconfigured until user space has set a valid address.
>
> The related HCI_QUIRK_USE_BDADDR_PROPERTY was later added to similarly
> indicate that the device lacks a valid address but that one may be
> specified in the devicetree.
>
> As is clear from commit 7a0e5b15ca45 ("Bluetooth: Add quirk for reading
> BD_ADDR from fwnode property") that added and documented this quirk and
> commits like de79a9df1692 ("Bluetooth: btqcomsmd: use
> HCI_QUIRK_USE_BDADDR_PROPERTY"), the device address of controllers with
> this flag should be treated as invalid until user space has had a chance
> to configure the controller in case the devicetree property is missing.
>
> As it does not make sense to allow controllers with invalid addresses,
> restore the original semantics, which also makes sure that the
> implementation is consistent (e.g. get_missing_options() indicates that
> the address must be set) and matches the documentation (including
> comments in the code, such as, "In case any of them is set, the
> controller has to start up as unconfigured.").
>
> Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This patch has been recently merged to linux-next as commit 6ac517d8cf8b 
("Bluetooth: fix use-bdaddr-property quirk"). Unfortunately it breaks 
bluetooth operation on my Raspberry Pi 3b+, 4b+ and Khadas VIM3 based 
test systems.

Before this patch on Raspberry Pi 4b+:

root@target:~# dmesg | grep hci0
[   14.459292] Bluetooth: hci0: BCM: chip id 107
[   14.464283] Bluetooth: hci0: BCM: features 0x2f
[   14.470632] Bluetooth: hci0: BCM4345C0
[   14.474483] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
[   14.487275] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
[   15.347542] Bluetooth: hci0: BCM: features 0x2f
[   15.354588] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+-0159
[   15.361076] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0290
root@target:~# hcitool dev
Devices:
         hci0    DC:A6:32:12:38:D1
root@target:~#
root@target:~# hcitool scan
Scanning ...
         88:57:1D:AB:19:B2    Samsung Family Hub
root@target:~# hcitool | head -n1
hcitool - HCI Tool ver 5.50
root@target:~#


After this patch:

root@target:~# dmesg | grep hci0
[   13.979860] Bluetooth: hci0: BCM: chip id 107
[   13.984969] Bluetooth: hci0: BCM: features 0x2f
[   13.991444] Bluetooth: hci0: BCM4345C0
[   13.995300] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
[   14.005131] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
[   14.839465] Bluetooth: hci0: BCM: features 0x2f
[   14.846047] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+-0159
[   14.859859] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0290
root@target:~# hcitool dev
Devices:
root@target:~# hcitool scan
Device is not available: No such device
root@target:~# hcitool | head -n1
hcitool - HCI Tool ver 5.50
root@target:~#

Reverting $subject on top of linux-next fixes this 'issue'.

Let me know if you need more information about my test systems or to 
make some other tests.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

