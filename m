Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91E25FAA92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKCWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJKCWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:22:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC55C379
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:22:00 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221011022155epoutp0455722c1130512e080aeeb4c891ca417b~c4mvr5jTs0480704807epoutp048
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:21:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221011022155epoutp0455722c1130512e080aeeb4c891ca417b~c4mvr5jTs0480704807epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665454915;
        bh=Q1eCrmaO35cZuXOL9ehpifBczZ391rlrPHwGE4VqjAs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Ns59Fb0Bf69G5FSv5fTNrzhGLl4NxiwE3D1o2Lk1J5diE11SIWteAKmnaAMPSmerk
         +YegkICsXxHhwwc1Nk6pIeMZmiXyiXpJ7spxYllcp+iVbVu+epMMTf9gbZ8SnLUH3L
         YssDxSt0FxLgORDftjECh41tZ6uB1ZZlGphmwOxc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20221011022154epcas2p3c7c79934c6d53390557d45d8fdf49d79~c4mu2Oq_L2218622186epcas2p3O;
        Tue, 11 Oct 2022 02:21:54 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Mmfg56pNpz4x9Q2; Tue, 11 Oct
        2022 02:21:53 +0000 (GMT)
X-AuditID: b6c32a47-873ff70000002127-f9-6344d341dcc7
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.7F.08487.143D4436; Tue, 11 Oct 2022 11:21:53 +0900 (KST)
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
Message-ID: <20221011022153epcms2p1fcbf889099bd74279ed0d9b51ff26c1b@epcms2p1>
Date:   Tue, 11 Oct 2022 11:21:53 +0900
X-CMS-MailID: 20221011022153epcms2p1fcbf889099bd74279ed0d9b51ff26c1b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmqa7jZZdkg5lrTS0ezNvGZrG37QS7
        xcufV9ks7h87zWJx8GEni8W0Dz+ZLT6tX8Zq8fKQpsWqB+EWi25sY7K4vGsOm0X39R1sFsuP
        /2OyWLr1JqPFh546B36Py1e8PS739TJ5LN7zksnjy9SXzB4TFh1g9Gg5uZ/F4/v6DjaPj09v
        sXj0bVnF6PF5k5xH+4FupgDuqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKBHlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5
        xaV56Xp5qSVWhgYGRqZAhQnZGdMX72EseCFcsfXWO7YGxqXCXYwcHBICJhJrn6p2MXJxCAns
        YJS4tWYXC0icV0BQ4u8OoBJODmEBH4lnvd8ZQWwhASWJ9RdnsUPE9SRuPVwDFmcT0JGYfuI+
        O8gcEYHNLBLP1nUxgSSYBeokds/5wwZiSwjwSsxof8oCYUtLbF++FayZU8Bc4vSKh+wQcQ2J
        H8t6mSFsUYmbq9+yw9jvj81nhLBFJFrvnYWqEZR48HM3VFxS4vbcTVD1+RL/ryyHsmskth2Y
        B2XrS1zr2Ah2A6+Ar8TeS1vB5rAIqEp0vrkMdaeLxO77EDazgLbEsoWvmUFhwiygKbF+lz4k
        2JQljtxigfmqYeNvdnQ2swCfRMfhv3DxHfOeMEHYahLrfq5nmsCoPAsR0LOQ7JqFsGsBI/Mq
        RrHUguLc9NRiowJjeNQm5+duYgSnaC33HYwz3n7QO8TIxMF4iFGCg1lJhJdxvlOyEG9KYmVV
        alF+fFFpTmrxIUZToC8nMkuJJucDs0ReSbyhiaWBiZmZobmRqYG5kjhv1wytZCGB9MSS1OzU
        1ILUIpg+Jg5OqQam1d83b7+10zF5TvvWVXmqJwXNpZyX3lpzoErwYkvJkbInmmqn2QWezT7/
        m3X1Nf/wRYK1O7aZ3uOYtOXUlVtTZHTqHRWslKbOkd/t/NBc1Fpv5qZ30Z77Zky4kJYeax/r
        2CBUs+eBZXTNhz3apf7mfxUuLp8r1s7j/m3n1ye1fXd9AiWPTFNL+KZV7xJec8LFwuy/R7//
        89ePi7Y9/1q1Tmxu2aTeks2/Vvl0mGxPsY+c1Gmecj9Kc+oH2a4Dx0Luz+jIdk2pMDAKyJNi
        vOHvxh7J19+4zjDjieerPsGS+Ac/jlRtOrbbsHAZ184N8h/7JTsm7uLLPD9X4m+g9G6BsvmF
        b133zr8klb6uR3q6EktxRqKhFnNRcSIAyKMnK1oEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221010093042epcas2p2462d3c50d81d613574332e3f39d971e1
References: <20221010092937.520013-2-beanhuo@iokpp.de>
        <20221010092937.520013-1-beanhuo@iokpp.de>
        <CGME20221010093042epcas2p2462d3c50d81d613574332e3f39d971e1@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean=C2=A0Huo,=0D=0A=0D=0AI=20think=20ufs_is_valid_unit_desc_lun()=20is=
=20also=20used=20for=20wb_buf_alloc_units_show()=20in=20ufs-sysfs.c.=0D=0AS=
o=20just=20removing=20this=20if-checkup=C2=A0will=20make=20different=20resu=
lt=20when=20check=20lun=20value.=0D=0A=0D=0AThanks,=0D=0ADaejun=0D=0A=0D=0A=
>From:=C2=A0Bean=C2=A0Huo=C2=A0<beanhuo=40micron.com>=0D=0A>=0D=0A>LUs=C2=
=A0with=C2=A0WB=C2=A0potential=C2=A0support=C2=A0are=C2=A0properly=C2=A0che=
cked=C2=A0in=C2=A0ufshcd_wb_probe()=0D=0A>before=C2=A0calling=C2=A0ufshcd_r=
ead_unit_desc_param(),=C2=A0so=C2=A0remove=C2=A0this=C2=A0unnecessary=0D=0A=
>if-checkup=C2=A0in=C2=A0ufs_is_valid_unit_desc_lun()=C2=A0to=C2=A0match=C2=
=A0its=C2=A0function=C2=A0definition.=0D=0A>=0D=0A>Signed-off-by:=C2=A0Bean=
=C2=A0Huo=C2=A0<beanhuo=40micron.com>=0D=0A>---=0D=0A>=C2=A0drivers/ufs/cor=
e/ufshcd-priv.h=C2=A0=7C=C2=A03=C2=A0---=0D=0A>=C2=A01=C2=A0file=C2=A0chang=
ed,=C2=A03=C2=A0deletions(-)=0D=0A>=0D=0A>diff=C2=A0--git=C2=A0a/drivers/uf=
s/core/ufshcd-priv.h=C2=A0b/drivers/ufs/core/ufshcd-priv.h=0D=0A>index=C2=
=A0f68ca33f6ac7..2457b005101a=C2=A0100644=0D=0A>---=C2=A0a/drivers/ufs/core=
/ufshcd-priv.h=0D=0A>+++=C2=A0b/drivers/ufs/core/ufshcd-priv.h=0D=0A>=40=40=
=C2=A0-300,9=C2=A0+300,6=C2=A0=40=40=C2=A0static=C2=A0inline=C2=A0bool=C2=
=A0ufs_is_valid_unit_desc_lun(struct=C2=A0ufs_dev_info=C2=A0*dev_info,=0D=
=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err(=22Max=C2=A0General=C2=A0LU=C2=A0su=
pported=C2=A0by=C2=A0UFS=C2=A0isn't=C2=A0initialized=5Cn=22);=0D=0A>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return=C2=A0false;=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0/*=C2=A0WB=C2=A0is=C2=A0available=C2=A0only=C2=A0for=C2=A0the=
=C2=A0logical=C2=A0unit=C2=A0from=C2=A00=C2=A0to=C2=A07=C2=A0*/=0D=0A>-=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(param_offset=C2=A0=3D=
=3D=C2=A0UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS)=0D=0A>-=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return=C2=A0lun=C2=A0<=C2=A0UFS_UPIU_MAX_WB_LUN_ID;=0D=0A>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0lun=C2=A0=3D=3D=C2=A0UFS=
_UPIU_RPMB_WLUN=C2=A0=7C=7C=C2=A0(lun=C2=A0<=C2=A0dev_info->max_lu_supporte=
d);=0D=0A>=C2=A0=7D=0D=0A>=C2=A0=0D=0A>--=C2=A0=0D=0A>2.34.1
