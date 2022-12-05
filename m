Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB416421A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiLECkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiLECj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:39:58 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC8E1004D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:39:56 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221205023954epoutp0255c1d104cd5cddac6ff86af8663a668a~txVJNp_sL1749317493epoutp02J
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:39:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221205023954epoutp0255c1d104cd5cddac6ff86af8663a668a~txVJNp_sL1749317493epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670207994;
        bh=50UGsAw1rXD4ZgtF7vH+fy0ilu9mFDwX04c9LAe6laY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tI27SESlSoC5ZDlwdLktjtyzZRbYdpuoUTUQLgzBuNMzx7PCvjzhcI7v7mVolh+Fz
         PO2YrbiK6+70770yKSktu/RqLZY+qOG93WsuJembK5iD2W3iHs0ITj6n/fJC2j7RAU
         e/37jsg/oSrbngz2xzWKIGvkxW6Q7obMtQt/S51s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20221205023953epcas2p2d10e2d21ce85537a64aa80ac36e95458~txVIc1X-d2235322353epcas2p2I;
        Mon,  5 Dec 2022 02:39:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NQSSS5RC6z4x9Q0; Mon,  5 Dec
        2022 02:39:52 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.A1.10048.8F95D836; Mon,  5 Dec 2022 11:39:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20221205023952epcas2p4607a09793766062b4c86011934be64db~txVHTvkZM1374313743epcas2p4G;
        Mon,  5 Dec 2022 02:39:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221205023952epsmtrp1cbb2859276792fc07f0c0143c3e16017~txVHRTRNY0055100551epsmtrp1D;
        Mon,  5 Dec 2022 02:39:52 +0000 (GMT)
X-AuditID: b6c32a45-529ff70000002740-19-638d59f8d162
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.5E.14392.7F95D836; Mon,  5 Dec 2022 11:39:51 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221205023951epsmtip11660f7ee4fb7bef5f8869ee462053812~txVHArB4i1815218152epsmtip1G;
        Mon,  5 Dec 2022 02:39:51 +0000 (GMT)
Date:   Mon, 5 Dec 2022 11:34:13 +0900
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
Message-ID: <20221205023413.GD54922@ubuntu>
MIME-Version: 1.0
In-Reply-To: <f633b0f3-9fdb-8beb-7edf-7967c7c0c3d5@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd3rb2xYDXhDYAbeJF6aCgC3jcTTCdLBxnSSD8cfU6WpXrpRQ
        2q4Phi4+hgFKQUHACEUUWrMawsAVcAIyw0OGJGuXVUDZWCBDIiAB1BmeZn2x+N/n9/7+zi+H
        g3mt4P6cDKmKVkiFEhJ3Y97uCUZhi4cviHgW/XY0du02jtbK+tjocWkDQGUFL1noeq+ZhQaM
        dQx03tCEo6uPI9Do+CITXXw6jqHOmVY2qlg1MpDpnyEWsrZfxVGl5RcG0v+Qh6HzpgoWmpnP
        ZaK8zl420o4+svXs8kHLLdNgny+1slwGqDbdKJsy3J1iUKb6Qpz6a+guTl17kELdq2lgU803
        zlIXW+oB1dQyyKRemN5L3nAkc6+YFqbRigBaKpKlZUjTY8mDqYJ4QVQ0jx/G341iyACpMIuO
        JROSksM+yZDYdiUDsoUStc2VLFQqyV1xexUytYoOEMuUqliSlqdJ5DHycKUwS6mWpodLadUe
        Po8XEWVLPJ4pXl4rAvJhzxxLVSF2Dhg9tIDLgUQkvG7S43b2Iu4AWLEm0wI3Gz8H8F6/ieU0
        XgE49tMctl7xrK+S7Qx0AjhSMOIyJgD8t87CsmcxiSD4m2EV2BknQuDfi/2Oam8CQcOtOkdb
        jJhjw8K+ErY9sIlIhQX5lx3sTuyEhS9XcSd7wgdVE0wt4HC4RBysK2bZ0cfWf7rrrL0NJMq5
        sGRSz3SqS4ATM/MupZvg9K8tbCf7w6mSfBdnwuFXRa78HHizc50/gLrJAodmjBDDBd2YYywk
        AmHvCNPp9oCanjW20+0ONflezspAeMVaynKyH+yaMbsUUHDEUO16nhoMXmgbx0rBFt0bi+ne
        mObkUFjb8RzX2UZgxGZofM1xYjBsat9VC1j1wJeWK7PSaWWEnP//rUWyLBNw/IKQj++A8tn5
        8G7A4IBuADkY6e2+zVAs8nJPE548RStkAoVaQiu7QZTtTJcwfx+RzPaNpCoBP3I3LzI6mh8T
        EcWLId92r67QiLyIdKGKzqRpOa1Yr2NwuP7nGBtZ6n252ODgjj192rjcP4Eb94lUL5a31x+6
        fKbo8/vZ1rrToaamjsV468ktoU+qLINLp3Nuff2p1lKr0r+TWvtz88PvPFaP7siu9LUOP6pa
        yrtf/v7DhYak0MRyQVnc2hfebYnk9xXizuLJieAXflcOnNH83q5pzTcXBx1soxu3H5jKcQt7
        5hnvl6Kb6eCNpQyETqiFG76tObE5ojlY1PjRj4XfSNpu+C+eqm8+MvI66Gn1JXP0Z28x3uWb
        t+2X6/tnuStD/bydCzePfbl1Y6BH/1Gr2PiV+DBrfnQlP2lAY04YPTR2grs01fhH+OyHx7Tx
        x40trYnldA/Oa9QZhwRbc+dUJFMpFvJDMIVS+B9ml4n5jgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO73yN5kg+czzC0ezNvGZvF30jF2
        i5sT1jBaTGr/wmox/8g5VotTyxcyWTQvXs9mMeemkcXdhz9YLPpePGS22Pt6K7vFlD/LmSw2
        Pb7GanF51xw2ixnn9zFZLFrWymzRvGkKq8XrD00sFq17j7BbdN29ATTzoKjFry2vGB3EPH7/
        msTosXPWXXaPxXteMnlsWtXJ5nHn2h42j3knAz32z13D7rF5Sb1H35ZVjB7rt1xl8fi8SS6A
        O4rLJiU1J7MstUjfLoEr49TFmcwF0/krPm/5wtrA2MDTxcjJISFgIvHm2Az2LkYuDiGB3YwS
        X45dZIFISEosnXuDHcIWlrjfcoQVxBYSeMQocXhHMIjNIqAicXbxH0YQm01AS+LejxPMILaI
        gIXE4g0LWUGGMgt8ZZc4cOsBE0hCWCBYor1tKthQXgFtic4vf9ggNs9llni1dQ0zREJQ4uTM
        J2BXMANNvfHvJVAzB5AtLbH8HweIySlgJ7GwhxXEFAW64dXB+gmMgrOQ9M5C0jsLoXcBI/Mq
        RsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgWNbS3MG4fdUHvUOMTByMhxglOJiVRHjV
        FvckC/GmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDU7HB/
        Wf8Z5sP9y7YkX2+OX5+85PXqv4bsB8KfqP1UE1E7kxK5MM2J61zJ//rYpNlbbPuPHVt4uvVo
        id8GR44nas5798iI8nOJG/YIfhdqUFTMDDnjuebQzw1WOtcUmP+xSv6ZWp9f2iZ07cy15l92
        /EckC7evUPq+71FiunJVSVtw/Co9b1WN73KKj5/FFB2vlLRTN2ucdL9q1sl/MRwXuGbYCt/b
        O3n7tkUuJ8S4mOzMX2fFznkx/WIo2wnpjDcFC8+82FVkGzSnLjaxwtLX5slkj9zMd72x1w7p
        vDw96e0ZHfFD7eHSwhPzjq2w0Nq9+R2P0Q4PBiXrWicdW2M2xqVWIhPdHO153KNvsyuxFGck
        GmoxFxUnAgAKUfXKVAMAAA==
X-CMS-MailID: 20221205023952epcas2p4607a09793766062b4c86011934be64db
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_15483_"
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_15483_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Dec 02, 2022 at 01:23:56PM +0100, Krzysztof Kozlowski wrote:
> On 02/12/2022 13:22, Mathias Nyman wrote:
> > On 1.12.2022 11.01, Arnd Bergmann wrote:
> >> On Thu, Dec 1, 2022, at 09:06, Greg Kroah-Hartman wrote:
> >>> On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
> >>>> This driver works with xhci platform driver. It needs to override
> >>>> functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
> >>>> scenario of system.
> >>>
> >>> So this means that no other platform xhci driver can be supported in the
> >>> same system at the same time.
> >>>
> >>> Which kind of makes sense as that's not anything a normal system would
> >>> have, BUT it feels very odd.  This whole idea of "override the platform
> >>> driver" feels fragile, why not make these just real platform drivers and
> >>> have the xhci platform code be a library that the other ones can use?
> >>> That way you have more control overall, right?
> > 
> > Agree that overriding the generic platform driver xhci_hc_platform_driver
> > from this exynos driver is odd.
> > 
> > But I don't understand how this works.
> > Where are the hcds created and added when this xhci-exonys driver binds to
> > the device? all this driver does in probe is the overriding?
> > 
> > Am I missing something here?
> 
> Because it is not a driver for Exynos... it's a driver for wakelocks for
> their specific Android use-cases which the manufacturer ships for their
> Android devices. Due to Google GKI, they try to squeeze into upstream.
> But this is huge misconception what should go to upstream and Samsung
> does not want to keep discussing. They just send random patches and
> disappear...
> 
> Best regards,
> Krzysztof
> 
> 

No. It's driver for Exynos. Currently It only has wakelocks but I will
submit one by one. Please think as the first patch of exynos not
squeezed.

Best Regards,
Jung Daehwan

------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_15483_
Content-Type: text/plain; charset="utf-8"


------3fo7lev8HRxwEdfRbJiPjGY7XcYF58l8nMiK-NSEDm8eBp4M=_15483_--
