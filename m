Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12A5FE622
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJNATU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJNATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:19:17 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DEB17FD75
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:19:09 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221014001902epoutp0283e1a2276cdfba0ee0a6d4a2539d9959~dx3UO4UF-1340813408epoutp02J
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:19:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221014001902epoutp0283e1a2276cdfba0ee0a6d4a2539d9959~dx3UO4UF-1340813408epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665706742;
        bh=rqXAjaHpfln9gpBUX+6RlIbjUZqJtG0vecuVAC7NO8I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=EEMAP6LXGIyD6IYED3mAxAuRvJn22QGQnJQ6WEOGViafeNMbWRAQU91prkEq5gk4z
         17nyZITGEQXCCswj9BOBnTQwC3CWjvZKLoUEGmqAi3jHFeeO51C0OdNQ5celGPqc6C
         aqqlFatBhkEwYgVhkF7Qi/QgQnzxH3IKZKaN96Fs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20221014001901epcas2p3c4eb7a45d1b139ed4ed1192b5de76bba~dx3TWaCAV1960119601epcas2p3t;
        Fri, 14 Oct 2022 00:19:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MpRnx2P0Fz4x9Pw; Fri, 14 Oct
        2022 00:19:01 +0000 (GMT)
X-AuditID: b6c32a46-5bdfb70000004e8a-bf-6348aaf48d19
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.F2.20106.4FAA8436; Fri, 14 Oct 2022 09:19:00 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Bean Huo <beanhuo@iokpp.de>, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20221010092937.520013-2-beanhuo@iokpp.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221014001900epcms2p227bbd97b905dfc284028818e81781f76@epcms2p2>
Date:   Fri, 14 Oct 2022 09:19:00 +0900
X-CMS-MailID: 20221014001900epcms2p227bbd97b905dfc284028818e81781f76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmue6XVR7JBh+mW1g8mLeNzWJv2wl2
        i5c/r7JZ3D92msXi4MNOFotpH34yW3xav4zV4uUhTYtVD8ItFt3YxmRxedccNovu6zvYLJYf
        /8dksXTrTUaLDz11Dvwel694e1zu62XyWLznJZPHl6kvmT0mLDrA6NFycj+Lx/f1HWweH5/e
        YvHo27KK0ePzJjmP9gPdTAHcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNz
        i0vz0vXyUkusDA0MjEyBChOyM+4tXM1csIy/YtHPZpYGxjd8XYycHBICJhKPD0xnBbGFBHYw
        SuyZIN/FyMHBKyAo8XeHMEhYWMBH4lnvd0aIEiWJ9RdnsUPE9SRuPVwDFmcT0JGYfuI+UJyL
        Q0RgM4vEs3VdTCAJZoE6id1z/rBB7OKVmNH+lAXClpbYvnwrWDOngLnE6RUP2SHiGhI/lvUy
        Q9iiEjdXv2WHsd8fm88IYYtItN47C1UjKPHg526ouKTE7bmboOrzJf5fWQ5l10hsOzAPytaX
        uNaxEewGXgFfibam/WB3sgioSnQs/Qg100ViyfolUPdrSyxb+JoZFCbMApoS63fpg5gSAsoS
        R26xwHzVsPE3OzqbWYBPouPwX7j4jnlPmCBsNYl1P9czTWBUnoUI6FlIds1C2LWAkXkVo1hq
        QXFuemqxUYERPGqT83M3MYJTtJbbDsYpbz/oHWJk4mA8xCjBwawkwusS4pYsxJuSWFmVWpQf
        X1Sak1p8iNEU6MuJzFKiyfnALJFXEm9oYmlgYmZmaG5kamCuJM7bNUMrWUggPbEkNTs1tSC1
        CKaPiYNTqoHpqk3Liqo3Sx5ZXuhL/RJUk54W782cvut42cWC+d4NMoWJ957wHFD5s333tuKj
        U4X+Z30tSbn06WaRiJ+6KuOJTzxrnJyYVIO+xsUf4Y+81lLLsYFlo2yB3KMKz0eLYzcvPXft
        Xt+Upwvf1PIv4qnZZb7Irdx6R2K7xZo7O7dzW7zoPHi5sa5Ey9X6sfNFn/rZ1yz3LnA10L2p
        F/Z1Ov+WvVWdr/uM7qis6E/6vv77Ipbsi+EPj81xmbfEYsXf4mkG13N3xvDfSty06mZ4wjlR
        JZ/ZvzZ9b304rXXqPCeO89Kb+KKWZiYIHT3g/97xMdPUhcsMubrCPwRe/cs2oV38+Twj9awz
        i/bc1auzcTmtrMRSnJFoqMVcVJwIAKNOFPtaBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221010093042epcas2p2462d3c50d81d613574332e3f39d971e1
References: <20221010092937.520013-2-beanhuo@iokpp.de>
        <20221010092937.520013-1-beanhuo@iokpp.de>
        <CGME20221010093042epcas2p2462d3c50d81d613574332e3f39d971e1@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

> LUs=C2=A0with=C2=A0WB=C2=A0potential=C2=A0support=C2=A0are=C2=A0properly=
=C2=A0checked=C2=A0in=C2=A0ufshcd_wb_probe()=0D=0A>=20before=C2=A0calling=
=C2=A0ufshcd_read_unit_desc_param(),=C2=A0so=C2=A0remove=C2=A0this=C2=A0unn=
ecessary=0D=0A>=20if-checkup=C2=A0in=C2=A0ufs_is_valid_unit_desc_lun()=C2=
=A0to=C2=A0match=C2=A0its=C2=A0function=C2=A0definition.=0D=0A>=20=0D=0A>=
=20Signed-off-by:=C2=A0Bean=C2=A0Huo=C2=A0<beanhuo=40micron.com>=0D=0A>=20-=
--=0D=0A>=20=C2=A0drivers/ufs/core/ufshcd-priv.h=C2=A0=7C=C2=A03=C2=A0---=
=0D=0A>=20=C2=A01=C2=A0file=C2=A0changed,=C2=A03=C2=A0deletions(-)=0D=0A>=
=20=0D=0A>=20diff=C2=A0--git=C2=A0a/drivers/ufs/core/ufshcd-priv.h=C2=A0b/d=
rivers/ufs/core/ufshcd-priv.h=0D=0A>=20index=C2=A0f68ca33f6ac7..2457b005101=
a=C2=A0100644=0D=0A>=20---=C2=A0a/drivers/ufs/core/ufshcd-priv.h=0D=0A>=20+=
++=C2=A0b/drivers/ufs/core/ufshcd-priv.h=0D=0A>=20=40=40=C2=A0-300,9=C2=A0+=
300,6=C2=A0=40=40=C2=A0static=C2=A0inline=C2=A0bool=C2=A0ufs_is_valid_unit_=
desc_lun(struct=C2=A0ufs_dev_info=C2=A0*dev_info,=0D=0A>=20=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0pr_err(=22Max=C2=A0General=C2=A0LU=C2=A0supported=C2=A0by=C2=A0=
UFS=C2=A0isn't=C2=A0initialized=5Cn=22);=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return=C2=A0false;=0D=0A>=20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=7D=0D=0A>=20-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
*=C2=A0WB=C2=A0is=C2=A0available=C2=A0only=C2=A0for=C2=A0the=C2=A0logical=
=C2=A0unit=C2=A0from=C2=A00=C2=A0to=C2=A07=C2=A0*/=0D=0A>=20-=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(param_offset=C2=A0=3D=3D=C2=A0=
UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS)=0D=0A=0D=0AThen,=20there=20is=20no=20re=
quirement=20for=20=22param_offset=22=C2=A0argument.=0D=0A=0D=0AThanks,=0D=
=0ADaejun=0D=0A
