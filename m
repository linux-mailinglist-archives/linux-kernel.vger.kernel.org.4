Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753416D1455
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCaAtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCaAtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:49:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C5AEF89
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:48:57 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230331004852epoutp03e5078e3ae0f3455a75f3ef8a12237eb6~RWpUBjmdv1955119551epoutp03Q
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:48:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230331004852epoutp03e5078e3ae0f3455a75f3ef8a12237eb6~RWpUBjmdv1955119551epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680223732;
        bh=gDThxwW2ZyJzyMa9SqfvJALNjMv9Ij8E9I9DNzy3dy0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FDF19fY3DbSDwcoHsP8I9ap0abbl37ARHdqH9H3Yz09onRaOylVY6Bai6A7kefxEi
         Mn/FDYYNztxTMkQvQRUNazR6xGRZUbcNzS2TuHvG2Xfu/LwWZdg5KOd2R7ipfYQrmk
         0bXf6PvhZGumnQuU/rbSBmUXtxUJrlbzjz4FxNh4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230331004851epcas1p313d0c0d9d9e8dfcd01101ac5e99614a4~RWpTY9WXJ0332903329epcas1p3l;
        Fri, 31 Mar 2023 00:48:51 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PnhVp6kpxz4x9Pw; Fri, 31 Mar
        2023 00:48:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.87.37890.2FD26246; Fri, 31 Mar 2023 09:48:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230331004850epcas1p163d6e9f1eea2678dd00b35ff4cf01a7d~RWpSvOAwX0099200992epcas1p17;
        Fri, 31 Mar 2023 00:48:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331004850epsmtrp25963dc07e336a7b333e99e22e8fd686e~RWpSuevSJ1007710077epsmtrp2Y;
        Fri, 31 Mar 2023 00:48:50 +0000 (GMT)
X-AuditID: b6c32a38-5fbfa70000029402-44-64262df21128
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.4A.31821.2FD26246; Fri, 31 Mar 2023 09:48:50 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230331004850epsmtip11ed3e3fd0da5febacddd824f8a84eb94~RWpSjNnZb0876908769epsmtip1e;
        Fri, 31 Mar 2023 00:48:50 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Cc:     "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>
In-Reply-To: <ZCVgWX2t1fpGzZX9@smile.fi.intel.com>
Subject: RE: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
Date:   Fri, 31 Mar 2023 09:48:50 +0900
Message-ID: <010e01d9636a$8f23edc0$ad6bc940$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGAlEY1LzDm0raYXF7gtDG56/PSOwI4GWTXAXgcPsivqCf/4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmge4nXbUUg+YlJha9TdOZLK5/ec5q
        cXnXHDaL240r2BxYPOadDPTo27KK0ePzJrkA5qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
        MwNDXUNLC3MlhbzE3FRbJRefAF23zBygZUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScArMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwVl98wFWxkq5i9/CNzA+Nk1i5GTg4JAROJ
        dYcugtlCAjsYJXb/Suli5AKyPzFKLNw8lQ3C+cwosfT+PiaYjqfL1rNCJHYxSrzZMBOq6jlQ
        y7Q3LCBVbAJaEgvnzGcDsUUEYiXOPfnIDGIzC0RLtO1dzw5icwoYSbyc9AVst7CAt8Sp6cvB
        algEVCWePNkONodXwFKi93AbO4QtKHFy5hMWiDnyEtvfzmGGuEhB4ufTZawQu5wkNmx/ClUj
        IjG7s40Z5DgJgbfsEktPzABKcAA5LhKLLhZC9ApLvDq+hR3ClpL4/G4vG4SdLrHyyh2oeI7E
        6/vtjBC2scS7t2uZQcYwC2hKrN+lDxFWlNj5ey4jxFo+iXdfe1ghNvFKdLQJQZQoS3Q/eAEN
        Q0mJxU/vME5gVJqF5LFZSB6bheSBWQjLFjCyrGIUSy0ozk1PLTYsMIHHdXJ+7iZGcDLUstjB
        OPftB71DjEwcjIcYJTiYlUR4C41VU4R4UxIrq1KL8uOLSnNSiw8xmgKDeiKzlGhyPjAd55XE
        G5pYGpiYGZlYGFsamymJ84rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYJr0I8rOlcs7TVvlmorn
        +rmTcy8HV+wK2KaTEi1cpnO+6kmjTQ0/a/oSCUGJe4pnlftzUxbP/7Ldanbc7YJOTZWnc45/
        3HzjdciMv13h7jXHGe/HrHiuNlNo+YGco32T+9OZ5pY0KLzm3lam96n7cNbBpz1ls3TP6j9a
        NqEleX7lpDXLrvx0WWu2yWeOfcq0GymnL7xZd4DrXo1bb83qt9JVtxR217l+X+awk3PywU2Z
        GZpTzy/U3q+d+fS9/Mb9JypsJS9lNl241+D1mK14osCtaUvv8HxaO63G1/n0TnOu/mcT2tRY
        9avWlFTpLJe4v/ndXSHneveUh0qbHwvfj2Fe6nrm+LsNZkKdtReCpS8psRRnJBpqMRcVJwIA
        X7MWhg8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnO4nXbUUgzPt8ha9TdOZLK5/ec5q
        cXnXHDaL240r2BxYPOadDPTo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSujBWX3zAVbGSrmL38
        I3MD42TWLkZODgkBE4mny9aD2UICOxglbu1ig4hLSpxd/oi9i5EDyBaWOHy4uIuRC6jkKaPE
        1R3bWUBq2AS0JBbOmQ9WLyIQK3HuyUdmEJtZIFpiz/PNzBAN+xgl3h5pBktwChhJvJz0BWyZ
        sIC3xKnpy8HiLAKqEk+eQAzlFbCU6D3cxg5hC0qcnPmEBeQIZgE9ibaNjBDz5SW2v53DDHGn
        gsTPp8tYIW5wktiw/SkLRI2IxOzONuYJjMKzkEyahTBpFpJJs5B0LGBkWcUomVpQnJueW2xY
        YJSXWq5XnJhbXJqXrpecn7uJERwVWlo7GPes+qB3iJGJg/EQowQHs5IIb6GxaooQb0piZVVq
        UX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTFobcl1y03s91X+as141
        VP7rkugsP3OxtYPXx65v7/METzxtuX39u2weh7Dm+rDcBoMmwVq5g7Lbluwr6vGJciuq/ioz
        8dxC0dSNT0yq0tbKzhONnfn2XYmd3e2ADe/Kzyo2yxp8+KLNNHmnRYq/26Kg2v235ecG/tBb
        b2glpRZxy2/C5btOub/mPnH6IvJmX5JGhEPWPkexTSUJDqc/Hel/XaudFxo3Y2VVnu/OEKnC
        DzqZetsu/bTrWZNtf/5XRN9ueY+/UhGqE6vffVugw9gT+9Xv62ar0hCudUKOcxVytto7KhwJ
        UGr3/2XWzSC6g/HzeZ3PaZX7p9yMDDxu+zZ4zmPPKPGjz3ZuMv+qxFKckWioxVxUnAgAoc77
        gfkCAAA=
X-CMS-MailID: 20230331004850epcas1p163d6e9f1eea2678dd00b35ff4cf01a7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230330101146epcas1p2240da3a618b18cea96735bbd6fe3f322
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
        <CGME20230330101146epcas1p2240da3a618b18cea96735bbd6fe3f322@epcas1p2.samsung.com>
        <ZCVgWX2t1fpGzZX9@smile.fi.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko
> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, March 30, 2023 7:12 PM
> To: Bumwoo Lee <bw365.lee@samsung.com>; linux-kernel@vger.kernel.org
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
> <cw00.choi@samsung.com>
> Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation
> fixes
> 
> On Wed, Mar 22, 2023 at 04:39:51PM +0200, Andy Shevchenko wrote:
> > A few fixes to the documentation and some cleanups against extcon core
> > module.
> 
> Anything I should do with the series?
> Any comments on it?
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

Looks fine to me.

Acked-by: Bumwoo Lee <bw365.lee@samsung.com>

MR. Chanwoo, Would you please take a look at this patch series.

