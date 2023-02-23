Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D586A12D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBWW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBWW2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:28:54 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2061716F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:28:51 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230223222847epoutp04e5ab0e4b170849facf917c3669f83a10~GlKBhqwpC1215512155epoutp04y
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:28:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230223222847epoutp04e5ab0e4b170849facf917c3669f83a10~GlKBhqwpC1215512155epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677191327;
        bh=o9KYta4ctbL2UStjOW/LIGMt7jOHPPBKftbnoGU4ZZ0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=qJnjWkMELnQc0NLoy23WntwXsIEP2P6PdDEUYyWYE1ATbvPhbJ4yBM9ynH1N1DDfa
         XC/YkDsIP2UXiIkO3PdqjU5AQSnlTrtRyb0wFXGxQT5ltc9BCKKZ1mZKZSBSJvfSGT
         YY8gSRr68+jDH54cB/FQnGarJs6DasqPptYQSZTU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230223222846epcas2p2292a4cfaf6bc6db9830c3e18c4fa3edc~GlKArIbP51775317753epcas2p2S;
        Thu, 23 Feb 2023 22:28:46 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PN73L3MPtz4x9Ps; Thu, 23 Feb
        2023 22:28:46 +0000 (GMT)
X-AuditID: b6c32a46-743fa70000007a4b-fb-63f7e89e4442
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.84.31307.E98E7F36; Fri, 24 Feb 2023 07:28:46 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3] scsi: ufs: core: Add trace event for MCQ
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        JunWoo Lee <junwoo80.lee@samsung.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1677051569-81113-1-git-send-email-quic_ziqichen@quicinc.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230223222745epcms2p2a85ca78bc48f366869fa224afa18799d@epcms2p2>
Date:   Fri, 24 Feb 2023 07:27:45 +0900
X-CMS-MailID: 20230223222745epcms2p2a85ca78bc48f366869fa224afa18799d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmqe68F9+TDS7tl7A4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1eHtK0WPUg3GLRjW1MFrv+NjNZXN41h82i+/oONosDH1YxWiw/
        /o/JYvFyNYuFHXNZLCZd28Bm8fv7JDaLfR0PmCyWbr3J6CDscfmKt0fLvlvsHov3vGTy2LSq
        k81jwqIDjB4tJ/ezeHxf38Hm8fHpLRaPiXvqPPq2rGL0+LxJzqP9QDdTAE9Utk1GamJKapFC
        al5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0INKCmWJOaVAoYDE4mIl
        fTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMP8cSCq5LV9yb
        NZW9gfGaVBcjB4eEgInEgzfWXYxcHEICOxgl9vT3MoHEeQUEJf7uEO5i5OQQFnCQ+HnnNyuI
        LSSgJLH+4ix2iLiexK2HaxhBbDYBHYnpJ+6zg8wREZjJIjHz1m8wh1lgJ5NE8+0uJpAqCQFe
        iRntT1kgbGmJ7cu3gnVzCnhJHN2wkRkiriHxY1kvlC0qcXP1W3YY+/2x+YwQtohE672zUDWC
        Eg9+7oaKS0rcnrsJqj5f4v+V5VB2jcS2A/OgbH2Jax0bwW7gFfCV+PjxNFicRUBVYtayfVC3
        uUise74EzGYW0JZYtvA1MyhQmAU0Jdbv0oeEm7LEkVssMF81bPzNjs5mFuCT6Dj8Fy6+Y94T
        aCioSaz7uZ5pAqPyLERIz0KyaxbCrgWMzKsYxVILinPTU4uNCozgUZucn7uJEZzStdx2ME55
        +0HvECMTB+MhRgkOZiUR3qlM35OFeFMSK6tSi/Lji0pzUosPMZoCfTmRWUo0OR+YVfJK4g1N
        LA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqemFqQWwfQxcXBKNTAZJRXqx308UZAv5ZvZ75d2
        r+ZJ3gPplqvLxbb+qQtdFq4jrKm896DG1ZT1wgEyhxyrY/+4rT1dIxej8uckG+uT7iWHX9Sa
        dPjdPaE2u7TOVEZe5vkP7W89Zl94b/yuaRDa3FgZGrH+UW6JLguPb8jPFL+Yls2Mmct7T1/4
        vSdX+5A14/XHTCGBfC87dgaIv1y+5OZZk2yX+wc3qCwV4BaWtp7e03rIfbpc+tU/E7Yd9lrt
        3XB7wgFx/95u6ftageodpjeFKx+/eTnf/e7Cn/M8BNl1Q8128hofvl3Op/ThXnbgBkmOqvwt
        GXzftHQW6DSseDfXJjfcpLb18eEslT5rlfWdwe7P5p1Js3sYpcRSnJFoqMVcVJwIAK6ABtZy
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230222074027epcas2p4138c95d79ac3cd7dca4745080c747fa1
References: <1677051569-81113-1-git-send-email-quic_ziqichen@quicinc.com>
        <CGME20230222074027epcas2p4138c95d79ac3cd7dca4745080c747fa1@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ziqi Chen,

...
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3b3cf78..67cb90d 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> =40=40 -426,6 +426,7 =40=40 static void ufshcd_add_command_trace(struct u=
fs_hba *hba, unsigned int tag,
>  =C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20ufshcd_lrb=20*lrbp=20=3D=
=20&hba->lrb=5Btag=5D;=0D=0A>=20=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0s=
truct=20scsi_cmnd=20*cmd=20=3D=20lrbp->cmd;=0D=0A>=20=20=C2=A0=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0struct=20request=20*rq=20=3D=20scsi_cmd_to_rq(cmd);=0D=
=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20ufs_hw_queue=20*hwq;=
=0D=0A>=20=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0int=20transfer_len=20=
=3D=20-1;=0D=0A>=20=C2=A0=0D=0A>=20=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(=21cmd)=0D=0A>=20=40=40=20-456,9=20+457,16=20=40=40=20static=20voi=
d=20ufshcd_add_command_trace(struct=20ufs_hba=20*hba,=20unsigned=20int=20ta=
g,=0D=0A>=20=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20=C2=A0=
=0D=0A>=20=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0intr=20=3D=20ufshcd_rea=
dl(hba,=20REG_INTERRUPT_STATUS);=0D=0A>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0doorbell=20=3D=20ufshcd_readl(hba,=20REG_UTP_TRANSFER_REQ_DOOR_BELL);=
=0D=0A>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_ufshcd_command(dev_nam=
e(hba->dev),=20str_t,=20tag,=0D=0A>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0doo=
rbell,=20transfer_len,=20intr,=20lba,=20opcode,=20group_id);=0D=0A>=20+=0D=
=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(is_mcq_enabled(hba))=20=
=7B=0D=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0hwq=20=3D=20ufshcd_mcq_req_to_hwq(hba,=20rq);=0D=0A>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_ufs=
hcd_command_mcq(dev_name(hba->dev),=20str_t,=20tag,=0D=0A>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0hwq,=20transfer_le=
n,=20intr,=20lba,=20opcode,=20group_id);=0D=0AHow=20about=20passing=20membe=
r=20variables=20of=20hwq=20instead=20of=20passing=20hwq?=0D=0A=0D=0A>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=20else=20=7B=0D=0A>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0doorbell=20=3D=
=20ufshcd_readl(hba,=20REG_UTP_TRANSFER_REQ_DOOR_BELL);=0D=0A>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0trace_ufshcd=
_command(dev_name(hba->dev),=20str_t,=20tag,=0D=0A>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0doorbell,=20transfer_len=
,=20intr,=20lba,=20opcode,=20group_id);=0D=0A>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=7D=0D=0A>=20=20=7D=0D=0A>=20=C2=A0=0D=0A>=20=20static=20void=
=20ufshcd_print_clk_freqs(struct=20ufs_hba=20*hba)=0D=0A>=20diff=20--git=20=
a/include/trace/events/ufs.h=20b/include/trace/events/ufs.h=0D=0A>=20index=
=20599739e..604b2cd=20100644=0D=0A>=20---=20a/include/trace/events/ufs.h=0D=
=0A>=20+++=20b/include/trace/events/ufs.h=0D=0A>=20=40=40=20-10,6=20+10,7=
=20=40=40=0D=0A>=20=20=23define=20_TRACE_UFS_H=0D=0A>=20=C2=A0=0D=0A>=20=20=
=23include=20<linux/tracepoint.h>=0D=0A>=20+=23include=20<ufs/ufshcd.h>=0D=
=0AThen,=20it=20can=20be=20removed.=0D=0A=0D=0AThanks,=0D=0ADaejun
