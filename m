Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49F96C093B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCTDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCTDMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:12:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD4212AE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:12:39 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230320031235epoutp01786961c300f3526186e44cbb7ca24d81~OAgqS4G6X2100321003epoutp01Q
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:12:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230320031235epoutp01786961c300f3526186e44cbb7ca24d81~OAgqS4G6X2100321003epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679281955;
        bh=O8ay0lX3oJ1UcBFg01Nm8dEMfud6/Nlq8Yw+ZkwDUWY=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=KzSRpb4l5WlnJXV0Gz3nGKVSq4I5g8+8nAQxKUfU01XY/BQFEjN49Lu3Zonm8MUIT
         IPRcV+1MvDqcX0UFIo4n314RbWjNH/CYH+eOp+AeuBlr66E16XTBJe/rsBAdaSx0yb
         eESx7TvZdblBA5jGJbToQ4ZlEYZP9M7qZFMXTBgo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230320031235epcas1p10f473da7488ed312396153445c104c6d~OAgqDJpIE2636926369epcas1p14;
        Mon, 20 Mar 2023 03:12:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pg0Ck2JJfz4x9Q5; Mon, 20 Mar
        2023 03:12:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.19.52037.22FC7146; Mon, 20 Mar 2023 12:12:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230320031233epcas1p1935fe60f79150d908fe231143ee43e5f~OAgo3x02N2386623866epcas1p1N;
        Mon, 20 Mar 2023 03:12:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230320031233epsmtrp10b4dc3d500021bb9b753c31edc64cce6~OAgo3J5372217122171epsmtrp1M;
        Mon, 20 Mar 2023 03:12:33 +0000 (GMT)
X-AuditID: b6c32a37-7cbfd7000001cb45-12-6417cf22b0c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.31.31821.12FC7146; Mon, 20 Mar 2023 12:12:33 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230320031233epsmtip22d4998da23eb604d904045e95ab50105~OAgonOIhy0460904609epsmtip2L;
        Mon, 20 Mar 2023 03:12:33 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     "'Chanwoo Choi'" <cwchoi00@gmail.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3de6d1b0-51f8-368b-e73f-8c1e007bf7f8@gmail.com>
Subject: RE: [PATCH v4 4/4] extcon: Added extcon_alloc_groups to simplify
 extcon register function
Date:   Mon, 20 Mar 2023 12:12:33 +0900
Message-ID: <186501d95ad9$d0812d30$71838790$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwpruLkQHtvkv1HpH0sg7N5M4ENAH0S3UzAS4GlpEB5HtHCK8sLzSQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmrq7SefEUgxudAhbXvzxntXh2VNvi
        8q45bBa3G1ewObB47Jx1l92jb8sqRo/Pm+QCmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNN
        zQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAlikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVS
        C1JyCswK9IoTc4tL89L18lJLrAwNDIxMgQoTsjO2bl7CXHBPqmLBrrVsDYzdol2MnBwSAiYS
        exZuZuxi5OIQEtjBKNHwth/K+cQo8f/tRjYI5zOjRNvpb+wwLY9/vGeFSOwCSuy4xg7hPGeU
        +LXwNgtIFZuAlsTCOfPB2kUEljBKbO65xAyS4BSwldiybB6YLSyQInFo2Towm0VAVWJJ0zGm
        LkYODl4BS4ndm3RBwrwCghInZz4Bm8ksIC+x/e0cZogrFCR+Pl3GCmKLCLhJ9Czexw5RIyIx
        u7ONGWSvhMBbdollG1uhznaRaN7azQhhC0u8Or4FKi4l8bK/DcpOl1h55Q6UnSPx+n47VL2x
        xLu3a5lBbmMW0JRYv0sfIqwosfP3XEaIvXwS7772sIKUSAjwSnS0CUGUKEt0P3jBBGFLSix+
        egdqoodE070exgmMirOQfDkLyZezkHwzC2HxAkaWVYxiqQXFuempxYYFxvDYTs7P3cQIToha
        5jsYp739oHeIkYmD8RCjBAezkgiv3wLRFCHelMTKqtSi/Pii0pzU4kOMpsBgn8gsJZqcD0zJ
        eSXxhiaWBiZmRiYWxpbGZkrivOK2J5OFBNITS1KzU1MLUotg+pg4OKUamG7GrG/tWasbb2jt
        1dWmJr0rO/IbW2+fwEHJ7O2ZeYetPj3Nn8q1T/bFfelPPSoBb9wOqOSK33j6viLdrKUyI2zd
        nJ83dWUWz3w4l/vDPNFZivIqvi+m7uQ0S1x/XuZSP//PQtPwd5kndr8SX9Vp+2/pyjnFSVJ7
        A73ZTaUXHDJ41SEzQU/rj/N82etBF14yN3x9xid5RHZWT+ZCnRe/dp3TZXt+QmetiZJc4gWJ
        O1vUBGfdYQkSKI+dw7WT2W9BTGXc9YSyMJ0Zbru2vrvH89ww99wexQJN3et317M/zz7A739x
        25lTf00Lt00+rRE/w7B0rvaFO/WVT47H+N87H9n0wz/whdy33E/aCW+23VRiKc5INNRiLipO
        BACz1MzPEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvK7iefEUgynrjS2uf3nOavHsqLbF
        5V1z2CxuN65gc2Dx2DnrLrtH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZWzdvIS54J5UxYJd
        a9kaGLtFuxg5OSQETCQe/3jP2sXIxSEksINR4s2jRawQCUmJs8sfsXcxcgDZwhKHDxdD1Dxl
        lHh78AozSA2bgJbEwjnz2UASIgLLGCVOL9jKBpIQEnjDKPH0vBeIzSlgK7Fl2TywBmGBJImp
        PV/BFrAIqEosaTrGBLKAV8BSYvcmXZAwr4CgxMmZT1hAbGYBbYmnN59C2fIS29/OYYa4TUHi
        59NlYGNEBNwkehbvY4eoEZGY3dnGPIFRaBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY
        5aWW6xUn5haX5qXrJefnbmIER4CW1g7GPas+6B1iZOJgPMQowcGsJMLrt0A0RYg3JbGyKrUo
        P76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamwp2nlsxn+HJXbe6CWYwd
        PHu5k1ivcsoFeDVsTZulenDF9clyv0o02iKn1uy5vOrv7kJX1ZxC6Q0PWb98nch7VM+gWWWj
        Vq/gp5fX/DMbXu26fL1rZcfTQ2VBTjO64iZJbJNKunSd7a73hNnpAf/VL3ksfdiz5bqlQ2J+
        8iGGr42ZL5XTLjy9JfTGjH1nqoDQUXmWx+ZiNSqWwp3FJ5SSHz74G/bdxLM3Xm+RVnHvut4f
        fz8FMb/Rm7HlwRyhQgeZ/4umqVtbZnSoPni4dG7StKhuhd2ddiqnpjpIm23ID5U0ec5QL+5X
        fGW7kaK3au/t9s38r9g8uT7UFq/N4Hr8+d20zg2lvq6/TeUurAxTYinOSDTUYi4qTgQA5qOL
        PO8CAAA=
X-CMS-MailID: 20230320031233epcas1p1935fe60f79150d908fe231143ee43e5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230302090149epcas1p33a5cd34ed350301b547c2ac3914569d4
References: <20230302090143.46678-1-bw365.lee@samsung.com>
        <CGME20230302090149epcas1p33a5cd34ed350301b547c2ac3914569d4@epcas1p3.samsung.com>
        <20230302090143.46678-5-bw365.lee@samsung.com>
        <3de6d1b0-51f8-368b-e73f-8c1e007bf7f8@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Chanwoo Choi <cwchoi00@gmail.com>
> Sent: Monday, March 13, 2023 8:08 PM
> To: Bumwoo Lee <bw365.lee@samsung.com>; MyungJoo Ham
> <myungjoo.ham@samsung.com>; Chanwoo Choi <cw00.choi@samsung.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 4/4] extcon: Added extcon_alloc_groups to simplify
> extcon register function
> 
> On 23. 3. 2. 18:01, Bumwoo Lee wrote:
> > The alloc groups is functionalized from extcon_dev_register.
> >
> > Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
> > ---
> >  drivers/extcon/extcon.c | 58
> > +++++++++++++++++++++++++----------------
> >  1 file changed, 36 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c index
> > 321988231806..c366a7988daf 100644
> > --- a/drivers/extcon/extcon.c
> > +++ b/drivers/extcon/extcon.c
> > @@ -1181,6 +1181,39 @@ static int extcon_alloc_muex(struct extcon_dev
> *edev)
> >  	return 0;
> >  }
> >
> > +/**
> > + * extcon_alloc_groups() - alloc the groups for extcon device
> > + * @edev:	extcon device
> > + *
> > + * Returns 0 if success or error number if fail.
> > + */
> > +static int extcon_alloc_groups(struct extcon_dev *edev) {
> > +	int index;
> > +
> 
> ditto.
> 
> 	if (!edev)
> 		return -EINVAL;
> 
> > +	if (!edev->max_supported)
> > +		return 0;
> > +
> > +	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
> > +			sizeof(struct attribute_group *),
> > +			GFP_KERNEL);
> > +	if (!edev->extcon_dev_type.groups)
> > +		return -ENOMEM;
> > +
> > +	edev->extcon_dev_type.name = dev_name(&edev->dev);
> > +	edev->extcon_dev_type.release = dummy_sysfs_dev_release;
> > +
> > +	for (index = 0; index < edev->max_supported; index++)
> > +		edev->extcon_dev_type.groups[index] = &edev-
> >cables[index].attr_g;
> > +
> > +	if (edev->mutually_exclusive)
> > +		edev->extcon_dev_type.groups[index] = &edev->attr_g_muex;
> > +
> > +	edev->dev.type = &edev->extcon_dev_type;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * extcon_dev_register() - Register an new extcon device
> >   * @edev:	the extcon device to be registered
> > @@ -1236,28 +1269,9 @@ int extcon_dev_register(struct extcon_dev *edev)
> >  	if (ret < 0)
> >  		goto err_alloc_muex;
> >
> > -	if (edev->max_supported) {
> > -		edev->extcon_dev_type.groups =
> > -			kcalloc(edev->max_supported + 2,
> > -				sizeof(struct attribute_group *),
> > -				GFP_KERNEL);
> > -		if (!edev->extcon_dev_type.groups) {
> > -			ret = -ENOMEM;
> > -			goto err_alloc_groups;
> > -		}
> > -
> > -		edev->extcon_dev_type.name = dev_name(&edev->dev);
> > -		edev->extcon_dev_type.release = dummy_sysfs_dev_release;
> > -
> > -		for (index = 0; index < edev->max_supported; index++)
> > -			edev->extcon_dev_type.groups[index] =
> > -				&edev->cables[index].attr_g;
> > -		if (edev->mutually_exclusive)
> > -			edev->extcon_dev_type.groups[index] =
> > -				&edev->attr_g_muex;
> > -
> > -		edev->dev.type = &edev->extcon_dev_type;
> > -	}
> > +	ret = extcon_alloc_groups(edev);
> > +	if (ret < 0)
> > +		goto err_alloc_groups;
> >
> >  	spin_lock_init(&edev->lock);
> >  	if (edev->max_supported) {
> 
> --

Thank you for the review and I will send a new patch including what you
mentioned soon

Thanks,


> Best Regards,
> Samsung Electronics
> Chanwoo Choi


