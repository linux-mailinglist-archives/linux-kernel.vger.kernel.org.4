Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEAD6D8B6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjDFAFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjDFAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:05:18 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6E7A94
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:04:46 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230406000405epoutp024ed790eadbfac0082f92a27e55f475ac~TL57_2ZbY0058800588epoutp028
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:04:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230406000405epoutp024ed790eadbfac0082f92a27e55f475ac~TL57_2ZbY0058800588epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680739445;
        bh=lWYGoG0FmmVCnJuydXAiRY57m7vzGGk/nskJBK7osto=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=T2g1/k5MNjLlPCBGN9X8RNFQgEweIGF5nC1m0VYZ98q54+RQ1cASmTUz81ZrsaYkG
         tVC96DXWgClDBoOQGXxaFy6N4DHelQZo5RcluuqEv4poKYTrDA4M0Y3VH9cv22+6pH
         Euw0cX4zL8vnv2AT6PK2ZPQmAF/x5LvybYzF1H9k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230406000405epcas1p27af26fba461f738e921c543bc55c6c68~TL57mnOOc1358113581epcas1p2Z;
        Thu,  6 Apr 2023 00:04:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.240]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PsMDN5bBCz4x9Pv; Thu,  6 Apr
        2023 00:04:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.18.52037.47C0E246; Thu,  6 Apr 2023 09:04:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230406000404epcas1p1de0a8a7ebe6f054c101c62dc0738861d~TL56RVEqr0180701807epcas1p11;
        Thu,  6 Apr 2023 00:04:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230406000404epsmtrp2cc514edd0107be99fc11ee31910f03db~TL56QjuP83074930749epsmtrp2I;
        Thu,  6 Apr 2023 00:04:04 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-50-642e0c74850f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.EF.18071.37C0E246; Thu,  6 Apr 2023 09:04:03 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230406000403epsmtip12b2414cd7bcddc688099d48ffd0e598e~TL56HFOWw0054500545epsmtip1B;
        Thu,  6 Apr 2023 00:04:03 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     "'Chanwoo Choi'" <cwchoi00@gmail.com>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Cc:     "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>
In-Reply-To: <9c9ca17a-7211-633d-7072-44992ab6852e@gmail.com>
Subject: RE: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
Date:   Thu, 6 Apr 2023 09:04:03 +0900
Message-ID: <05ee01d9681b$4c444ad0$e4cce070$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGAlEY1LzDm0raYXF7gtDG56/PSOwI4GWTXAXgcPsgCpiKc1QJ4seOJr4iUQWA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTT7eERy/FYEezqEVv03Qmi+tfnrNa
        PDuqbXF51xw2i9uNK9gcWD12zrrL7jHvZKBH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2Tm
        pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVVSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgV6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfMOPmPseCpQMXbf3fZGxhX
        8XYxcnBICJhIdO8y7WLk4hAS2MEoMX9+M3sXIyeQ84lR4t6iCojEN0aJTWcmMcI0HDrlChHf
        yyjRcPwQO4TznFHixNJtbCDdbAJaEgvnzGcDSYgItDBKdN5/zgKSYBaIlmjbux5sBaeArcTF
        W0dYQWxhAW+JU9OXM4NsYBFQkWi6nQgS5hWwlNh06TcThC0ocXLmE6gx8hLb385hBrElBBQk
        fj5dBjZGRMBP4vLyy1A1IhKzO9uYQW6QEGjkkDh0opcNosFF4s32Z1C2sMSr41vYIWwpic/v
        9kLF0yVWXrkDFc+ReH2/nRHCNpZ493Yt2J3MApoS63fpQ4QVJXb+nssIsZdP4t3XHlZIYPFK
        dLQJQZQoS3Q/eMEEYUtKLH56h3ECo9IsJJ/NQvLZLCQfzEJYtoCRZRWjWGpBcW56arFhgTE8
        qpPzczcxgpOjlvkOxmlvP+gdYmTiYDzEKMHBrCTCq9qllSLEm5JYWZValB9fVJqTWnyI0RQY
        1BOZpUST84HpOa8k3tDE0sDEzMjEwtjS2ExJnPfLU+0UIYH0xJLU7NTUgtQimD4mDk6pBqaE
        d8rKIcUqS8Va7+RYaXEtaPqWPf3GdROzb7sKTr8sf/797GVTju8PU3uDzFbduj7l1aWgZfP8
        GkWfyV1YPLvsySGBmavmRprEizivSf5759GbP9np+inJXxn9JWoyHv4w3PhyRl5txabsVwEv
        3JJ1jlZZRAf83PmhqFdZ86lQjZLD0/UPJxzN3/f0ZXL1/Hj23aucd7WLXHO5aZ/nXX3jmJrl
        jwoX8Rv1vFGsn47fKvi6dxXngnt1y5MT3d5cu3bf7bdzxsPA9vyyhAK9mn9zFs1tSsk9fKPv
        1ArT6AvPj6jcX3FC1uP4yl17Ul5859vI2v5KI4yr6+zTGwFsgleblLwX7dirxL/gb8pH5UNG
        SizFGYmGWsxFxYkAlqeifxcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnG4xj16KweQeK4vepulMFte/PGe1
        eHZU2+LyrjlsFrcbV7A5sHrsnHWX3WPeyUCPvi2rGD0+b5ILYInisklJzcksSy3St0vgyphx
        8h9jwVOBirf/7rI3MK7i7WLk4JAQMJE4dMq1i5GTQ0hgN6PEmd1aILaEgKTE2eWP2CFKhCUO
        Hy7uYuQCKnnKKLH9x2smkBo2AS2JhXPms4EkRATaGCVuvPzADJJgFoiW2PN8MzNEx1wmiWVn
        3oIlOAVsJS7eOsIKYgsLeEucmr6cGWQDi4CKRNPtRJAwr4ClxKZLv5kgbEGJkzOfsEDM1Jbo
        fdjKCGHLS2x/O4cZ4lAFiZ9Pl4GNFBHwk7i8/DJUvYjE7M425gmMwrOQjJqFZNQsJKNmIWlZ
        wMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOFK0NHcwbl/1Qe8QIxMH4yFGCQ5m
        JRFe1S6tFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY
        zH6+LhRpKA7W/5CRfFN7f9iVK9nOtxfuZPn7Zf7itOCaExNEOreGKWke3Xvo1OIJsaf7Hsid
        7LxXmWHQGGI+P6l1ReCdvflSz96fSYk2P3wz9uiMuHVXMv7K3ZHn23Ej0TssdPMW9pgzl7O+
        /b+RdkEm8ExQdfXM1V8W/ueyXXH0xEG+M6WB3vv4bP4qa4tdjRf9FWjaO2vLjvPdZ1tW6dst
        bd84eeKBxItzl5384/nf4aBjZtDXy0u3idrs47L3u2Ayc6Ox8LRV/zP70/yvH72jW5+74Xlf
        h1z493AH32zf2923tZbZsnFsm9Bj/PnUsiLHEJaDlxe2CT6d81h149pcOV+JLnMVPQZejT4/
        ByWW4oxEQy3mouJEANf0EWgDAwAA
X-CMS-MailID: 20230406000404epcas1p1de0a8a7ebe6f054c101c62dc0738861d
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
        <010e01d9636a$8f23edc0$ad6bc940$@samsung.com>
        <9c9ca17a-7211-633d-7072-44992ab6852e@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> -----Original Message-----
> From: Chanwoo Choi <cwchoi00@gmail.com>
> Sent: Thursday, April 6, 2023 8:17 AM
> To: Bumwoo Lee <bw365.lee@samsung.com>; 'Andy Shevchenko'
> <andriy.shevchenko@linux.intel.com>; linux-kernel@vger.kernel.org
> Cc: 'MyungJoo Ham' <myungjoo.ham@samsung.com>; 'Chanwoo Choi'
> <cw00.choi@samsung.com>
> Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation
> fixes
> 
> Hi,
> 
> On 23. 3. 31. 09:48, Bumwoo Lee wrote:
> > Hi Andy Shevchenko
> >> -----Original Message-----
> >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Sent: Thursday, March 30, 2023 7:12 PM
> >> To: Bumwoo Lee <bw365.lee@samsung.com>; linux-kernel@vger.kernel.org
> >> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
> >> <cw00.choi@samsung.com>
> >> Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation
> >> fixes
> >>
> >> On Wed, Mar 22, 2023 at 04:39:51PM +0200, Andy Shevchenko wrote:
> >>> A few fixes to the documentation and some cleanups against extcon
> >>> core module.
> >>
> >> Anything I should do with the series?
> >> Any comments on it?
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko
> >>
> >
> > Looks fine to me.
> >
> > Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
> >
> > MR. Chanwoo, Would you please take a look at this patch series.
> >
> 
> Actually, Acked tag will be replied by Maintainer or the driver owner.
> If you want to review the mailing list patch, I think that Reviewed-by tag
> is proper.
> 

OK.
Thank you for your detail guidance. I will follow this guidance on next time.

> Unfortunately, I could not see the any review comment from you even if
> this patchset have the some review contents. Also you didn't review the
> any patches of extcon before.
> 
> I'm always welcome for many reviewers in order to improve the linux kernel.
> But, in this case, I'm not sure that you are reviewing this patchset.
> 
> So that I'm sorry that I cannot take your acked-tag.
> 

I agree your comment.
Thank you~

> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi


