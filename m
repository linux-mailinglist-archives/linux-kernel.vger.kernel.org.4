Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7833F6F64EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEDGZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDGZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:25:38 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569F26B5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:25:30 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230504062527epoutp028839cff298cbc6ffd48e1410e6599c3a~b3K5yEoJc0274002740epoutp02l
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:25:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230504062527epoutp028839cff298cbc6ffd48e1410e6599c3a~b3K5yEoJc0274002740epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683181527;
        bh=CkrMcGl++5RN8VR33y1VxUdx45B7GEdN0Z3RKYEynTU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Jy83nE5+QIGi7vsGveFVD18Jv3ywqhFVU5c5iIr5KZHsJE19Wgo01aXFHO5hkv1gK
         pZFVFFcBQepfvW19sttbY4pa8TlG9CpgaZlvY52hFFsIfUqy97DB0ME+vm/d7qrqvR
         PTWiVDCHkLN6yrk6kJVj9J+2SIlARi9mx6w/N3AA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230504062527epcas2p3409cd3a1ded723ed3294dc8616d34093~b3K5jqSLK3146031460epcas2p3j;
        Thu,  4 May 2023 06:25:27 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBkMV6vGlz4x9Px; Thu,  4 May
        2023 06:25:26 +0000 (GMT)
X-AuditID: b6c32a48-475ff70000005998-da-64534fd571e8
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.79.22936.5DF43546; Thu,  4 May 2023 15:25:25 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 01/15] block: bio: rename page_is_mergeable to
 bio_page_is_mergeable and make non-static
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230503155238.GA31700@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230504062424epcms2p2c32b61597200ed673f528dece82966b7@epcms2p2>
Date:   Thu, 04 May 2023 15:24:24 +0900
X-CMS-MailID: 20230504062424epcms2p2c32b61597200ed673f528dece82966b7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmue5V/+AUgy23rS1W3+1ns3h5SNNi
        5eqjTBZ7b2lbXN41h81i+fF/TA5sHpfPlnrsvtnA5vHx6S0Wj74tqxg9Pm+SC2CNyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqvpFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOWNAgUXCB
        rWLTiWnMDYwb2LoYOTkkBEwkzhw5x9LFyMUhJLCDUeLops2MXYwcHLwCghJ/dwiD1AgLFEpM
        /dLOCGILCShJnFszC6xEWMBA4lavOUiYTUBP4ueSGWwgYREBWYkrK+pBJjILPGGU2LxyPtQq
        XokZ7U9ZIGxpie3Lt4KN5BTQkbg5+QEzRFxD4seyXihbVOLm6rfsMPb7Y/MZIWwRidZ7Z6Fq
        BCUe/NwNFZeUOHToK9gNEgL5EhsOBEKEayTeLj8AVaIvca1jI9gJvAK+ErfXPAE7jUVAVWL2
        3U3sEK0uEl+2aoCEmQW0JZYtfM0MEmYW0JRYv0sfokJZ4sgtFogKPomOw3/ZYf5r2PgbK3vH
        vCdMEK1qEouajCYwKs9ChPEsJKtmIaxawMi8ilEstaA4Nz212KjABB6ryfm5mxjBSVDLYwfj
        7Lcf9A4xMnEwHmKU4GBWEuH9UOiXIsSbklhZlVqUH19UmpNafIjRFOjHicxSosn5wDScVxJv
        aGJpYGJmZmhuZGpgriTO+7FDOUVIID2xJDU7NbUgtQimj4mDU6qBaf4TXdU9ycyH7y2Y/bWg
        0cU4xu/ynodT5GZ15Djz/vcRr57zgT1novVOwxCV+1Hn1b8HVUwtDNKRPvrDKOnAE52On3P6
        XhjrP7jxacMq5eXZc8I4Hu9+tilyveOH+fNfR508t+THitccheaRtU8dim9tcHg6a6ET1y/L
        U6ZPO34z1TxduFCAd+U5Fb5r0tE8IcGSX0pqP14R0Ws6teDnuzUOn5euvXblrMR97QsxCobL
        PGzmH2Nedjwq9+Xj+5dWix10eFHx6HnVjBRlNtOZ2Zaz9gVy/Ao6JeqwXClG0OZN+XadlvRZ
        3WvOOfpcOhFsUiJtLTR9reX7aj3W5Us8WBWigh9MqXr81k395XXXZmUlluKMREMt5qLiRABx
        70QVCwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503155238.GA31700@lst.de>
        <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <20230503100049epcms2p2c830ebb7b50beaa2663abd0cd274293c@epcms2p2>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p2>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +bool bio_page_is_mergeable(const struct bio_vec *bv, struct page *page,
>> + =C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20unsigned=20int=20len,=20uns=
igned=20int=20off,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
bool=20*same_page)=0D=0A>=0D=0A>No=20bio=20involved=20here,=20just=20a=20bv=
ec.=20=C2=A0But=20I=20don't=20really=20see=20the=20need=0D=0A>to=20rename=
=20it,=20just=20declare=20it=20in=20block/blk.h=20where=20f2fs=20has=20no=
=20chance=0D=0A>of=20ever=20seeing=20it.=0D=0A=0D=0AOh.=20You=20are=20right=
.=0D=0AI=20will=20declare=20where=20you=20mentioned=20without=20changing=20=
the=20name.=0D=0AIt's=20better.=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung
