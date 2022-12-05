Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB446423F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiLEH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiLEH71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:59:27 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF48E11A22
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:59:24 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221205075923epoutp03b5e06d31cb4ceedf9f5842c781adb43e~t1sFuzRpb2699626996epoutp03Z
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221205075923epoutp03b5e06d31cb4ceedf9f5842c781adb43e~t1sFuzRpb2699626996epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670227163;
        bh=CnBi6MGS+LasE7pxEUAb6zR9jAPjBC6KvWbg8aXLdU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UBu7MGYqqgF4xxz0FfvuZDtcBdPzoKkSVz+OuDyfz720PpXa5WP8JkOQaSTam36er
         I5FmMSKHg5OvravNzvsrdkJMB26I4ttNVE3h1aHuBJiRNjnoXHT/+OncyuxHPpgRxU
         NSFkF8Z+uyp1cU67pVbR4WiYMTaHUBzMlXeLjiME=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20221205075922epcas2p387c33ea08f38257f72d62e8360fbd57a~t1sFKgQcp1911719117epcas2p3L;
        Mon,  5 Dec 2022 07:59:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NQbY56c48z4x9QF; Mon,  5 Dec
        2022 07:59:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.9C.12278.9D4AD836; Mon,  5 Dec 2022 16:59:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20221205075921epcas2p3f850eec608e344a1fed8a5f263ad05f7~t1sECO1642173021730epcas2p3y;
        Mon,  5 Dec 2022 07:59:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221205075921epsmtrp27b9d1c3aca7a469bb87122fe2827e454~t1sEA9Gf_2971029710epsmtrp2j;
        Mon,  5 Dec 2022 07:59:21 +0000 (GMT)
X-AuditID: b6c32a46-85fff70000012ff6-63-638da4d9c9ac
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.F0.14392.9D4AD836; Mon,  5 Dec 2022 16:59:21 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221205075920epsmtip1f9f34ecc356ce4b6f263a9bf9f88c268~t1sDuFH-91380213802epsmtip1y;
        Mon,  5 Dec 2022 07:59:20 +0000 (GMT)
Date:   Mon, 5 Dec 2022 16:53:42 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v1 2/2] usb: host: add xhci-exynos to support Exynos
 SOCs
Message-ID: <20221205075342.GG54922@ubuntu>
MIME-Version: 1.0
In-Reply-To: <92df8e1d-eb7b-ec0b-264f-a1a090cececc@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTZxjGc3ra0wOk5qxy+SzqWCHLQIG2QHtg1pgN4cwtGRvuEkeCJ+WM
        lkLb9bLAFgLOcZG7WFArMrRYkDHKpSOMURcuMtAIRjYcDIgEBgziJKBEYYW1HFj875fnfd7b
        9+ZDYe4GwkMVKj2lVZGpfMSd2d4bKA4eqy2WCW60hOGPqtsR3FHez8bHyhohvDzvKQv/rm+I
        hd+pu8bAz5qtCF41JsInp58z8ZKFaRi3L/3Ixo3/1jHw1plRFj7SWYXgl4ZvMfDrlhwYP9tq
        ZOFLy98w8Rx7HxsvmPzDWbPbC1+3LULHvImN9XKI+Mk0ySbMXX8ziNaGcwgxMdqFENWDHxC/
        XG1kE221WUSJrQEirLbfmcRq68E4j1PKI3KKTKK0fpRKpk5SqJKl/HfjE99OjBALhMHCSFzC
        91ORaZSUH/1eXHCMItW5K9/vSzLV4JTiSJ2OH3r0iFZt0FN+crVOL+VTmqRUjUQToiPTdAZV
        coiK0kcJBQJRhNN4Winfqpljae5w0jsHcpFsaMu9AHJDARYO7i5MMQsgd5SLdUBgbG0OcQW4
        2AoEnhWl04E1CBgbbrJ3MwoWOnZMdgh0rcfSplkILDebGa4AEwsApsqqbROCBYGp5wOwiz0x
        HJibr7FcCTD2hA3O9ZduV92LxYO83Ipt5mCHQNN88Q6/AgYvzzJd7IYdBY61W04dRb2cDRa7
        s1x1AFbqBhwtsxA9XTQotVoQmveCxV9tO1PzwOo/9h1dCR6uFTJpTgf19l0OA6a5vO06MCYH
        Iw8uIK5eAPMHfeNMWt4D8nsdbFrmgPxcLp3pDy6OlLFo3ge6l4Zgmgkwbr7Cpt9nFQbWwUK4
        DHrV9NJmppe60XwY1Py84mTUyb6gbhOlMRBYO0NrIFYD5E1pdGnJlE6kEf1/a5k6rRXa/gVB
        MR2Q8fFySA/EQKEeCKAw35PzurlIxuUkkRlfUVp1otaQSul6oAjnnc7DPC+Z2vmNVPpEYXik
        IFwsFkpEEQIJ34dzxZgv42LJpJ5SUpSG0u7mMVA3Xjajrt1QsrrywnqZ9K/s+mwk9/aUNOXj
        TN8Pi854bLLlSbaL6JCg9PsIhzT7YE7O8FR0fU8cFls1Pws/y3tjq9Hn+BnJzEyGsEdzn7Kc
        SPvcIklYHT8U+XXvjbmpR/Nl7y+KYzJ8KhO6FaN+Tzfvbog/svAfKNsnTKOhudejLvypviR7
        5zjLOEeuFLd8O1Mtfqi9mf2WQe6bcpicDlD017dtvvjBzfLXCdF+R0Li7SdZvwUYTw6/ecA7
        trmw7eSxWkPT2tVASKH39f3Uao9nR53mpRzYn7nO3Qp5fFzh4cnxkxpewypmB9gShBf+RaYS
        u7dn4pP7FU22U1X7xPfCzEWlKyI+UycnhUGwVkf+B8MOiFOOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCSnO7NJb3JBudnsVk8mLeNzeLvpGPs
        FjcnrGG0mNT+hdVi/pFzrBanli9ksmhevJ7NYs5NI4u7D3+wWPS9eMhssff1VnaLKX+WM1ls
        enyN1eLyrjlsFjPO72OyWLSsldmiedMUVovXH5pYLFr3HmG36Lp7A2jmQVGLX1teMTqIefz+
        NYnRY+esu+wei/e8ZPLYtKqTzePOtT1sHvNOBnrsn7uG3WPzknqPvi2rGD3Wb7nK4vF5k1wA
        dxSXTUpqTmZZapG+XQJXxsHfp1kLurgr5u68ytbAeIOji5GTQ0LARKLrxQ62LkYuDiGB3YwS
        f1dMZoZISEosnXuDHcIWlrjfcoQVougRo8TVuQ1MIAkWARWJWdPmsIHYbAJaEvd+nABrFhGw
        kFi8YSFYA7PAV3aJA7cegDUICwRLtLdNBZvKK6Atse55LzvE1M/MEgsO3mOGSAhKnJz5hAXE
        ZgaaeuPfS6BmDiBbWmL5P7CzOQXsJP5+28cOEhYFOuLVwfoJjIKzkDTPQtI8C6F5ASPzKkbJ
        1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4HjW0tzBuH3VB71DjEwcjIcYJTiYlUR41Rb3
        JAvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAZPzz1V0V
        gauNjf+5zk8viqi5GFhhkmwop2g84cZd0+YtkasZ737oDpKtDqkp2M1wd+KjV29nBjfNXdh2
        Q0lC6Zf5ii1vp2eZRx4X1Ygt9+h2fax9fcmtTRwXDnrwLckrXbfkvCu3jVzRXgmbyllBtcq7
        HurtStx1MeVd7anWK0niL9h5DW3XPW+vufkqSPlL11nZphuuMn3X+KJENlv9znVe/TO+suGv
        1/e6a/U/yn88Xzoj4cDJf7NSL+fwrZZbY8CzQbLjdklDacn5vaHrru68ay/ttbi6K0Y+JOpS
        spFSvZ9dw89tz01Oxof9PWJrENFincW+2oNhasDf9Z+vzVpaEP5QhfuixrvHuevclFiKMxIN
        tZiLihMB2RSaFFYDAAA=
X-CMS-MailID: 20221205075921epcas2p3f850eec608e344a1fed8a5f263ad05f7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_183f9_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
        <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
        <Y4hgnxGMEuizJumr@kroah.com>
        <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
        <ec0ce90c-b165-d84f-340d-4973b65609b3@linux.intel.com>
        <f633b0f3-9fdb-8beb-7edf-7967c7c0c3d5@linaro.org>
        <20221205023413.GD54922@ubuntu>
        <92df8e1d-eb7b-ec0b-264f-a1a090cececc@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_183f9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Dec 05, 2022 at 08:33:39AM +0100, Krzysztof Kozlowski wrote:
> On 05/12/2022 03:34, Jung Daehwan wrote:
> 
> >>> Am I missing something here?
> >>
> >> Because it is not a driver for Exynos... it's a driver for wakelocks for
> >> their specific Android use-cases which the manufacturer ships for their
> >> Android devices. Due to Google GKI, they try to squeeze into upstream.
> >> But this is huge misconception what should go to upstream and Samsung
> >> does not want to keep discussing. They just send random patches and
> >> disappear...
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> > 
> > No. It's driver for Exynos. Currently It only has wakelocks but I will
> > submit one by one. Please think as the first patch of exynos not
> > squeezed.
> 
> That's not how upstream kernel development works... Your code has
> nothing for Exynos. It's Android driver, not Exynos. If you say there is
> something for Exynos it must be visible here. Wakelocks are not relevant
> to Exynos, so after dropping them there would be empty stub in upstream
> kernel which obviously cannot be accepted.
> 
> Best regards,
> Krzysztof
> 
> 

Well, Exynos only uses wakelocks when I see mainline because it seems no
other driver use it. That's why I thought it could be a exynos specific.
Do you agree that if I put wakelocks into xhci platform driver?

Best Regards,
Jung Daehwan

------q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_183f9_
Content-Type: text/plain; charset="utf-8"


------q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_183f9_--
