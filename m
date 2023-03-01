Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F956A6BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCALej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCALeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:34:36 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D22DE47;
        Wed,  1 Mar 2023 03:34:35 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321B3R8S017362;
        Wed, 1 Mar 2023 03:34:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=xqM3urGs/3BhSYg25TID7bxyAwPVtlrnM5y/jL0cR/I=;
 b=N3v/vq8Rg7t5RjkF+MCUuR9XNuM7nPTWFQXRusqT51eNRuYHDI96p9SNbZ2VztGUbufs
 qiFPj9h0M1hI1Datmdp40Hj+kCmysBapiIQsC3CwENE9aNGp6NQKqj4nXsWDso6pT/lO
 oT2h5AJ8fF/5UHWsCr0AVDUM+L3nDgKei2I22dNHFbSTCOzUK0QQu7SKdceTP1bbMTUR
 w/ruyT+RgAq8Mblh1i+FGQNxogVJpifnIfYU1LMf+402UeIOq1I7mYa4wNAzISjHBaii
 /m8IUV7zWwxy4dwMF7RnseKNrhHs2SWi43z1dTR/co+cXt7tg78lbI1nV3YyCWRg1sM5 2A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3nyhumg7v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 03:34:26 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C8163400E8;
        Wed,  1 Mar 2023 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677670465; bh=UWiG1dNK5l3/Adz1L710g9GR04j43fCSY7py4NfQUJI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BVRtTBEK4oY0be7TCDYZdypWj0HGVF5Xshg98JP36zjKpQNTC2ePnorte69Sgl8Di
         DgBIagGucny6wXQdt//almCJkhSwjsj6BkR4VJx5Th8uOKlLxzYazjxznWs7s66Z5q
         xTpsVCG5+vRnqHMLxRAtPOqOP6dAd+BFfdUdAbXZBCYerNzoPLZ1DtdHPEhNqUCsMm
         oNhqxPq+Qa3TBMInPXvDdKAVq/1HnLDcCg8u2fFYnPR5qr6b8sPErU8hDbaa6iWIzL
         vRtKvVgRjQ8cQprDcbrsyFWlSzqrjszlw/QxTqa27laxTVp1NmcKHn71FK+jxEdbr1
         pAK/1acerfy8A==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8FBA6A005C;
        Wed,  1 Mar 2023 11:34:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 968A14006A;
        Wed,  1 Mar 2023 11:34:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="mlEGd+MI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgQfWaGn9Bb6fucvTd5XgpfWfDaNrAjdituQPBSo31i4ZBrR6movOTq5oNpH3N3DD/+Xs3GCc0ac0G7R1Q+5EDmasZx83JYp5nPsAb0LsTqRkOfYRRURiY8X3a5RpNkK1HnHc2d5fBQWyr/E88xU5f33ITz4FMnLf0j3Z4eFH6q49dKnFwEYLAaJPk1kn8u/JmybpS1P1TQdkRJHxt6RUJIkMswgel24FYDtF86FN2L1eOqQUT6aRVruSugEUcc04ODrLJaRB51JtJJH1fMMrN1G+O8hEvFLK+ppIdz7CqGgmOjO6uoK4rPhlDzoBe7o7KIhiKdy9JpRoTMCuhD4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqM3urGs/3BhSYg25TID7bxyAwPVtlrnM5y/jL0cR/I=;
 b=ofoEn1dHPT3VXa4STb07cLsKFJsjDvibWj5uRzSorrRC6fG+f6aYUOpXrNQMAECCaJ63UhzKC6YECPV/U4PwWdjcPEWcLxu1sPvt18oGX0BI8Y8BThgo5XId7UyaP2ROA0/5v9c26rSewyMmB/lMB0uesrIedW7lHbieHECPaNIkfMIrIlZMQV5PQISXfFra8BF4Oq/8Lxnt9dQUYTEe94mQprg3e/9pmmDOqiflzIbKzvYPL8pj6c5xw5cXgXyAmUZyL66rVbfVzkjEUgA81t7oZjpQiVdSIO2oIC7oeaaFIUK/f0T9QXFGk44MS6B5GlU3acXERXFjN+CUSgxv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqM3urGs/3BhSYg25TID7bxyAwPVtlrnM5y/jL0cR/I=;
 b=mlEGd+MIroZiU65Dcl+X3nA2HukgmVhVevpDndB69e4kpQjboJkQXRwHAS+979OfrIABdQwx4H1hWqfzMi4Usq0pReMhWxNPrCQim2JHs61e/6u11Rgm6tjDH0RztH4hvAk8rC7a0EukJ2ZAzJD8TpQu/ftIjAF5UnYGdKseRUE=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 11:34:19 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe%5]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 11:34:19 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Ziyang Huang <hzyitc@outlook.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Thread-Topic: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Thread-Index: AQHZRd+knSYE4gin9E6iCq3Lba7rya7l1ssQ
Date:   Wed, 1 Mar 2023 11:34:19 +0000
Message-ID: <BYAPR12MB339967000494531F9B700611A7AD9@BYAPR12MB3399.namprd12.prod.outlook.com>
References: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaG1pbmFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZmY0NmNhMGYtYjgyNC0xMWVkLWIwNmMtNWM1ZjY3?=
 =?us-ascii?Q?NjdkNDhiXGFtZS10ZXN0XGZmNDZjYTExLWI4MjQtMTFlZC1iMDZjLTVjNWY2?=
 =?us-ascii?Q?NzY3ZDQ4YmJvZHkudHh0IiBzej0iMjQ3NSIgdD0iMTMzMjIxNDQwNTY5Njcy?=
 =?us-ascii?Q?NDg2IiBoPSJKQkpNL3UrNXdtMVB5NFpoRnlucGc2ZDBjZnM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUFt?=
 =?us-ascii?Q?QTUvQk1VelpBZnJ4RTltNXFLTWsrdkVUMmJtb295UU5BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFBR0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQTJXMC9vZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCdEFH?=
 =?us-ascii?Q?a0FZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lB?=
 =?us-ascii?Q?YndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpB?=
 =?us-ascii?Q?SFFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFl?=
 =?us-ascii?Q?UUJmQUhBQVlRQnlBSFFBYmdCbEFISUFjd0JmQUhRQWN3QnRBR01BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJtQUc4QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRB?=
 =?us-ascii?Q?QnVBR1VBY2dCekFGOEFkUUJ0QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?Y0FkQUJ6QUY4QWNBQnlBRzhBWkFCMUFHTUFkQUJmQUhRQWNnQmhBR2tBYmdC?=
 =?us-ascii?Q?cEFHNEFad0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCaEFHd0FaUUJ6QUY4?=
 =?us-ascii?Q?QVlRQmpBR01BYndCMUFHNEFkQUJmQUhBQWJBQmhBRzRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBR0VBYkFCbEFI?=
 =?us-ascii?Q?TUFYd0J4QUhVQWJ3QjBBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJnQndBSE1BWHdCc0FHa0FZd0JsQUc0?=
 =?us-ascii?Q?QWN3QmxBRjhBZEFCbEFISUFiUUJmQURFQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdVQVh3QjBBR1VB?=
 =?us-ascii?Q?Y2dCdEFGOEFjd0IwQUhVQVpBQmxBRzRBZEFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCMkFHY0FYd0Jy?=
 =?us-ascii?Q?QUdVQWVRQjNBRzhBY2dCa0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|DM4PR12MB6009:EE_
x-ms-office365-filtering-correlation-id: a42d894b-dc12-424a-31c1-08db1a48e56e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+aBtElncbpQlyish7jPvmIVF77h0jAX/dPGcj50o90+t+MKU5ePHN6ITg6C9Gj/Ez+k80g+4fvAWfcmpJ4yllCxzHHw2m/pW3VwZjFkoPCqnJZyVgbTTOQcd9iNeNgKwLAVXrV0abCqjC0Hp+ppVfG3cO0vaiC93Hs4xjLvWutb3L/aqNVc1bWAmQgADPhquRFGBdw4F34ZuMGAwsdM8YJJFTKom5uCr610HrqhJGmTZuzxuApeB5EDk5lWWCdy+9yLVaZUjsxroGOLx9nOkx0ajvSMVEBpVjciXU+NCY8IjANl7eUgVi0O0N3+Spef3x7U8S5gBLHFrtdx5op7X1+duisEtyC4E4vGOaE+K9nC9K+QdUcM6qXCs/w3DO2LBNQRNBpTOgq2imjOSSTQ5ztT3JLAzIIlH/8WVXIzlx2K1XWlrxBhxsGZd1zxjZX5Gvq/sjkYT1iK2wSEc9qTBTY4K7njsyG+0vzvQ0mKdO2NYdE+h3AUKXQ/rKdsgGTIcRasrzUUAdsQi1hdZE1osM8LBN1+WZ9qwO5ixuM5MO+of5LoSfvWCjHDdk9lavru/VWHL7sikFH11I5+y7xTjXLENZL4SCv6uRlwOT2rJUzOsryAfhbfCZwF/PXBG60moRtEL9ITVv8OYtLA9sZB6BNDC0RwOg+bzGTqbAQ6+09d2vcK/1E5S3fe8DryMZGOUubM6GkQDr9W9mvkTl1/3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199018)(71200400001)(33656002)(478600001)(122000001)(5660300002)(9686003)(186003)(26005)(38100700002)(6506007)(53546011)(52536014)(8936002)(83380400001)(7696005)(2906002)(54906003)(55016003)(86362001)(41300700001)(38070700005)(316002)(64756008)(66556008)(6916009)(66946007)(66476007)(8676002)(66446008)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJYk59pGa1ymg16vNqmXtT3vT0QFuZCfCJx4nUooxt98M3po5UElVhmK5lEM?=
 =?us-ascii?Q?Xq1voW2k2X9Q8y1Xx+uDBRycokczg1t03zriGYdJclFfRv79xcFq/ZPBDXi1?=
 =?us-ascii?Q?0k97IQsWvETmle8z63NvkzOD9zgtaOS7XVXaSJH0xLmMiZj4xITdlY5cYIdt?=
 =?us-ascii?Q?uID9snXaZD60/OmO0HldVypLfceqeCjOU2L8PNSESA1rPLfm4Uu4hPDJ4Grx?=
 =?us-ascii?Q?9tJGg+n1nPVFNUCgrpln4KMJvJtdu4ocf7OAatl+exAtzSdHpdxmt5hF6sdd?=
 =?us-ascii?Q?MprkzmbbS9WQEevfieGbOGHSLfX8wlevd/C4hrHvmysvSzaXx2p44WaHm9sy?=
 =?us-ascii?Q?dl6X0llgUgvTuLAjF3WaGMMZcJ9LmggGKTCb4OhX/efeQ7UP6Pzp26bUgBDp?=
 =?us-ascii?Q?sj+miqfB9e3vz+NW4STuo57TmiQ+9a3GcOb959RiYcM3XwyYfV8vt4gLdtft?=
 =?us-ascii?Q?27IFg5KxGlIXFefs0ZYFhYykdddvzl/t1HcIJUOVO5cawVPu9TGY64QkrcJ4?=
 =?us-ascii?Q?2ezrg1LzlRb5NuxwqEgGGQoW3DCWe34HTGjOLqq6d1RGZnVqPBzQdDND9EEz?=
 =?us-ascii?Q?m5wqYHzTfhNyC5K/VI6alFyAFZ/mU6Pz5Rai4rR1+srxde8k/H9OwVhc8kvX?=
 =?us-ascii?Q?LlSs6OrSHGJ5X5sYxHa4Ih7lG6qoHi0CK6osP0JBcJ6Zepy+Vqcp3lzd5XDr?=
 =?us-ascii?Q?VbbtVwkiLJsWTfSrsJ/0s1wW/K3DfQBstM8T9FLt/+Plg7oTW4s//AYeOVLr?=
 =?us-ascii?Q?cYsAdlKbdfFE/SsonfEDfZoFAq8ClPQtZYd6uPYc4/9QbBBwer1CPss2Vyyd?=
 =?us-ascii?Q?1DyBT1hZJXrXhYxmGDIEblbRrID5X3ZgnZqqa9T72FYac5LG3mgAMCGamABq?=
 =?us-ascii?Q?UFPQa+OuATlPqdtEJXgP4kAJ62ujG+tJWmnyyoMAKvF76j360uPvRy9GOVU8?=
 =?us-ascii?Q?KIi+m+8f+Zo56tCmWQefPXxZPb/go+nJ/S1McmKbI3JV5HtwDYQpBVmhuNLx?=
 =?us-ascii?Q?L4dVXKxXhp8JDxlnURDoueluvA+7ersnS5srutq74hDc22KxSvrSdmG/aOTa?=
 =?us-ascii?Q?c2PZL96afVbpAlRcii4MmnWMDcZIplmlhyEq47sICSDTJpivZNOnGDVU1iX8?=
 =?us-ascii?Q?uSCMoDQ7o2AJEOjI+J52U4y/8EWw9N2Ma5dPlEG5nmZO/HKkl0p9jGdxqll0?=
 =?us-ascii?Q?6dHjcEymILcNqETjqwoM/TZsFAHnrL1Y4w5FE3MvkPaWC8ZeuEjtIoa+5Whu?=
 =?us-ascii?Q?YyrpvLorhjJk2f/4B12I415OhNf6qwwa2bsic696cKfZy96spHGacBYZ+uRm?=
 =?us-ascii?Q?yPvWH59Nvnk0d3FgN6k6m5udwnvaEEXRdSFuG6sgkQ7h+yDCxDN3vp9VS3de?=
 =?us-ascii?Q?v5OT53CnRxhGUjAIyR11ZzuQkc8Fi3p8YVCOaINvbWbCFjH0hhLv75cWHPKJ?=
 =?us-ascii?Q?oAbBdS7pRWfTswBZ22IVPIpomFs/9Uh9F7X2Q6CfgnvjOLAUJrWrLbIpR15v?=
 =?us-ascii?Q?P5JJ9cyKrtwpiloAUErXIBRcKJ/A2W7Y6T2Kt2wyxPIS5Dwpm9ASSnztJR0b?=
 =?us-ascii?Q?eY+51NdNR8Z4axvygM0DGxpl/29J9eQUtteyAGW8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1uLdDmNAh8YTTI3T8vOVx6kzgMLmEXOmnL3U1b+ILdGJhav/TiYJ1uewIHzF/0BCeKvLgt8dGIJqhauOu1MgSLLtXj6+Pl9sYCvrfbchRe4ziZ8WOadE2+C79gLZvDg3AQ3H36ili8hFmakqEbRaoHX3Q6wmh8uUMN3Z2lwqcc5qLyKpDgWyb6K6wDGZTf1llsugHLiQ3Syg9fDEdkZueFNVs2rYt9lKRuVmhVq/TnFbtr08J98r/ETunt+EVQWHB2QtZOABRM9ZH94EeeE7Jqxj59aWgEHUMZnTE+LGiqvSWUYvAONPYVfquLrujQeohf7j0inNVEaXjU3Mjgkp2H8Lqrs0bkU3owEWUa4JcJ8pJ2T06f8F1PXLflLPUeIEgd1mjHGEqrtOT8fdAQqR/t/hAOU8Vb18e6zbIFfpANCP4HlNvC9oDL8X82hHobXjt9UK1XcXRszaQjtBYxono1F+I35g9V5nyXTacpWq+kl21lv3MeENk4KY6IpC/KPDHWimuuDUfRVQbT9VCnLpZLsj00Icaom1iKwxkJUCWo0sIl3b0cJnWkBSlku3k//K7Fdm1mDtpthgtqOmVXG0ESXIPaqvbMwfOkH/sCqfNJPxvHDu+/3z5dF42mp/2Y5oUVx3CaZrEgTWSoabq4+dbmbog0egxyWcRbSuoC6EeHpKu/NT12iiLAk/KNhEnQq8I3LdplY71POC9PMJXnq9OjvOPB9dxe7bRu/4v73iL/Qxt7Pf7TEYO43Ts0NY0ouXBy0029zcsmnlbNtM+69oMZASQtTc8sGujR4Bq+nXB1tTt9sU+AGXghPA0wlRxGJoxnIV1o761QrNcvmZFN0bx4M+cR2/lox3Lckb10YqwOWfGd2JJ78jrxfUGVPAENIQ9JSKb7WpYlhXtxktBicBVWHLO+ReTaH7B013iJXaZ2s=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42d894b-dc12-424a-31c1-08db1a48e56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 11:34:19.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csIX/Ar+q75M4PuTlWfm8kmshmyQkdWj+PX3hE41Qclc98g520w2lH+i0hCIk5JkwQsZBBDlEiq1qVSw+3msYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
X-Proofpoint-GUID: o0b8xyfzlVUE2vPDlJM5fvluMBON8vSo
X-Proofpoint-ORIG-GUID: o0b8xyfzlVUE2vPDlJM5fvluMBON8vSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_07,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ziyang,

On 2/21/2023 2:30 PM, Ziyang Huang <hzyitc@outlook.com> wrote:
>From: Ziyang Huang <hzyitc@outlook.com>
>Sent: Tuesday, February 21, 2023 2:30 PM
>To: Minas Harutyunyan <hminas@synopsys.com>
>Cc: gregkh@linuxfoundation.org; fabrice.gasnier@foss.st.com;
>amelie.delaunay@foss.st.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Ziyang Huang <hzyitc@outlook.com>
>Subject: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if role-switch-
>default-mode=3D"host"
>
>Some boards might use USB-A female connector for USB ports, however, the
>port could be connected to a dual-mode USB controller, making it also
>behaves as a peripheral device if male-to-male cable is connected.
>
>In this case, the dts looks like this:
>
>	&usb0 {
>		status =3D "okay";
>		dr_mode =3D "otg";
>		usb-role-switch;
>		role-switch-default-mode =3D "host";
>	};
>
>After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
>dwc2_force_mode() with parameter host=3Dfalse, which causes inconsistent m=
ode
>- The hardware is in peripheral mode while the kernel status is in host
>mode.
>
>What we can do now is to call dwc2_drd_role_sw_set() to switch to device
>mode, and everything should work just fine now, even switching back to
>none(default) mode afterwards.
>
>Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support=
")
>Signed-off-by: Ziyang Huang <hzyitc@outlook.com>

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>


Thanks,
Minas


>---
>Changes since v1
>- Use corrent name in Signed-off-by
>
> drivers/usb/dwc2/drd.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c index
>d8d6493bc457..a8605b02115b 100644
>--- a/drivers/usb/dwc2/drd.c
>+++ b/drivers/usb/dwc2/drd.c
>@@ -35,7 +35,8 @@ static void dwc2_ovr_init(struct dwc2_hsotg *hsotg)
>
> 	spin_unlock_irqrestore(&hsotg->lock, flags);
>
>-	dwc2_force_mode(hsotg, (hsotg->dr_mode =3D=3D USB_DR_MODE_HOST));
>+	dwc2_force_mode(hsotg, (hsotg->dr_mode =3D=3D USB_DR_MODE_HOST) ||
>+				(hsotg->role_sw_default_mode =3D=3D USB_DR_MODE_HOST));
> }
>
> static int dwc2_ovr_avalid(struct dwc2_hsotg *hsotg, bool valid)
>--
>2.34.1

