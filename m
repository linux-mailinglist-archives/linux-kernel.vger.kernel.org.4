Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FF6762F5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjAUCNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUCNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:13:15 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BBC70C6B;
        Fri, 20 Jan 2023 18:12:52 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30L1hiY3031429;
        Fri, 20 Jan 2023 18:12:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=idLDBPx2+GoAwfIljDE5+pNfFzTmJ2WENS1YNWyT9bs=;
 b=qv1dAgBiYBu1fJe9DMxe6T+mGkw14+/N7fjvGmbvTNwnUcFlGlKXdo1NJJB69u99IDhm
 ftlRJp9BGdNsY0NzWyix+Yxe8NjdWjk7LwqeEkJK5N+rvOyZaN3c0e1JEYRLNS6mhly4
 THZvcQYnS7XeBkQm/pLcOQ/CnweHfdSF63yNJsNFi2YfoQqWCG4M4lDxPtmSWS4Qo6qB
 JB/IudI9jksE/a3RT0bq9sXuTeaNG+9JJovBjIgd6I7gjUFBnXE1xvktkehquCMEc4Md
 vqGgzyoNAy8Inwuba0ABBHmzPbxDEX4jPowCM56pzU9MeOXRAms7JolyuIrq4an1g8Sj dg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3v9st3jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 18:12:38 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E315AC098D;
        Sat, 21 Jan 2023 02:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674267158; bh=idLDBPx2+GoAwfIljDE5+pNfFzTmJ2WENS1YNWyT9bs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jaVu7gS8p7YUbUwrtu1guJfcq8wHp2n5l4m279f1EtJCv+qgYL4H5OiNUkOwNZCM1
         J1biUiTNkZzDwFM0KMCfk/sTOQTBoRncBC0wbDrUrWlEWH1TFeQjaHZ7eaPpEooFaf
         2ntp8VGVMQEKvm4CekbIbMgnkXMfjq8SUOk7gZWquUqfV43k8J+vgNAQc5r6j+NW/g
         ElnY6bSv6Rh1NU0Jyd4ODKQFaDY33GC+Adyya+A2vdgGAL00BeJ/sfUWFNBM6jmZRt
         1KKJII7bCEJBtYA3B3O0ktusFiv0uV5AS6Jy+ivoQLY7dUmejMORazuE1XOrbmPBYz
         TR/ZazFptu7eQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3D4A4A0077;
        Sat, 21 Jan 2023 02:12:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 69136800B5;
        Sat, 21 Jan 2023 02:12:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="otsVSDcM";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5czqXJSm+iZSqWRqYny2uTgyvDR4dM/IoT2FwFGfhFwNnpG9qqDfsXGpCFNxraAqZPfxQ5uxX58yL6TV0qEgsBWGXcK/UYktDFug/7y5f3UaHDx3PbEx19Y1FH2OsPQQiExaI/HZKTw8IShdDN7v0BrCC72vFvnETIwRepkhtiv3bt/Mxoxg9GRVtXw4h1Oxgg/okjBV2vLXtzNTWlNcEygMoGunCrUYAlmZ/LKZ548X1g79pCmr42HbLK7wuirrJEN1sS48IcRfBDmJIE2CwHgQY6a66RiBB027ffCqy/NZG7ypf188GsclXFW2b+aRZjcn/u1AYsWgn4RYpPIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idLDBPx2+GoAwfIljDE5+pNfFzTmJ2WENS1YNWyT9bs=;
 b=TyOnPsyNp+4D+aoeDm7OKEv0P1vWKRzfOp+UHAe5KoASJ9DRVvAuCLAdzHvwZgiV4DkeVtJkBwpEnjGs5uWuTd9EYygEjHPtMYSAvUGdAYt80Y0NGeKbUom83Gvulv2fe0rIZKzrOvd/fFV0jKdsLdubYigbyEw/V2JvOYaXXNlH5X0ZMqqZcgOTpPTiEMAG7ott/LSoqtTLeTALkQmNHKvqFZqB4XHm3thJ8ztsxdXCNxglI8Kv2AuKjAeBr9ImC0tzyRKI9K8SyDm0BdZvXjadpjOxykG9hZ2aF/B8asPIEWqbAykqZ9kjQgor4YVISe3qbuZ3U81vr+1+f3QBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idLDBPx2+GoAwfIljDE5+pNfFzTmJ2WENS1YNWyT9bs=;
 b=otsVSDcMEbK2qkV82jPOxvycnB2bxE3iafh0ky+GOVC2u/1P2L22s0BJprc4QSpxy0sK59+ukt5z16jyram2Z6CShBURH8X7Ev29/8ONbXCAaPxDKp5DKQLKEGSrf5OTxFnkKLqvIYkpJvbqvE8MyGdllRMzfeSqWL393hJCj/E=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sat, 21 Jan
 2023 02:12:32 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219%7]) with mapi id 15.20.6002.026; Sat, 21 Jan 2023
 02:12:32 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Serrao <quic_eserrao@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Topic: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Index: AQHZKr5r/qObzpub/UasYeFFzcErsq6k+Y6AgAF5HgCAABEigIABfykAgAAEBYCAABpUgIAAAgCAgAABMYCAAAGWgA==
Date:   Sat, 21 Jan 2023 02:12:32 +0000
Message-ID: <20230121021219.udgpwt7tv7dfr3jk@synopsys.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
 <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
 <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
 <20230121002059.mpiqavemelnntxd7@synopsys.com>
 <Y8tGAXbKDtzmW8+E@rowland.harvard.edu>
 <20230121020223.l2tyvyqifc7umqpy@synopsys.com>
 <Y8tIrx+F/4X9YyFT@rowland.harvard.edu>
In-Reply-To: <Y8tIrx+F/4X9YyFT@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|PH7PR12MB6538:EE_
x-ms-office365-filtering-correlation-id: 0175d377-8fe0-49c0-81e8-08dafb54f4ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G8PWJkm4DnTvppDzk8qFTxi2ISLd80eMmfZavH/8ElNb0uOkGVaBTT3FjcPZlVEGp0paFFd/t4Y1daoltrCthuv62op0AsMCXpByZuNUNOLQ/rNvlb6tImZsf2BHbYW00XSZKFuq4NUNiR4QyyVGxVHSdhD+VHHBEXOzmjVDzCR0wNdsXPD61qmC6T2fxc/m71yjRwI5esyS3du2OAoDcZ3hUyOCxgDQWk+s/VAQO1SJwKikiTGpxgnKEcBVKgLsh8oUUslvd37mDM0a6kFrFql9sH3JQfeRvPLspQLhFu15CssQTEYbyYCIswsA56ZREUmPfqZg5v74UMNskz2GzjgrpL73z/y43XrWGsWrmX41Ok/4SjHCj9RMUhDstOfSZnSbvO5jF2JNytWX5N6ZSirXua6c5o+nRA1oL1afq2xqFm5EdMo1o2up0uX2hyljm5kASpZjblM6UNOC9n3GJnFqLu8zakLk8RSsaT6eNXKZ8P3YYepPeTTJYbpmOaZz1eZypnE3Urzlru9+fI4X3XD+/OeI4jJLrfjmkWIep/su2dvgdPzUWDDIv6CGr9pe9ssmb0c5lOQdrsCVZN1vesqwdcbPRdeQe07ciL/+AGcqfRpkLuBfdXOsP37RnMbREEMoXYGWmrm2Z6i1blqjmCqsuw/QA3o0I5dSd/elBHLJRBtwaP2ZU11oSOINUE2KKJtkhYKZiTLZnzGwTZoiyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(6916009)(6486002)(478600001)(8936002)(66899015)(5660300002)(38100700002)(66476007)(26005)(64756008)(36756003)(66556008)(76116006)(66946007)(8676002)(71200400001)(91956017)(66446008)(4326008)(41300700001)(2906002)(316002)(86362001)(54906003)(38070700005)(122000001)(6506007)(186003)(6512007)(83380400001)(1076003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFVBaXBxM3NwNmVHWXhxVVJnRTZydVVOOFhkdGR5OEw2VzRRT0NvSUZPZFJ6?=
 =?utf-8?B?bjNZcEZJbVlEQ0s2K1pCbkJjWlUrREtPa0lycVozSVdtbURXWE5TVW5RbGpI?=
 =?utf-8?B?Z3kxM04rbHB3OHlaUnJibE5nOFY4b0Rabk1zNDA4V3BSbnFJb0FnUW9sYStm?=
 =?utf-8?B?Mzd1a21zTzkydVYzMWgyV0RrU2lFemhjTzY2K2d5NHpMYzNraW44NW9KOWZX?=
 =?utf-8?B?ZVB5VHdueCtsN3pnMXhIcVJiY0daMGxpUzVnQjRwNk5ydGQrT1EzNDZaOUpQ?=
 =?utf-8?B?ZGk1QWEvM0FyNVo0WnNWdFNIcXBPQkZBK1FjTE9ZdTN3MTJCUEcwR0FpMW1z?=
 =?utf-8?B?UTlxaURockxXWlMrTFY4cDEzc240dFJ4S0R6L1FQUHJwL3E3QUZnT3l5RS9H?=
 =?utf-8?B?SFRRcy93RkxCLytjVXJvMDJveU1sdjlTRSs5SUhpZEQxY1NobGJLbnJmNXl6?=
 =?utf-8?B?eFBrcGlPMFFPY0Z3S3FYTnZyKzZUN1Q5VzBYcmoyWXRNazdNbWcwQzU2S3Ry?=
 =?utf-8?B?TTR3Y3Ayd2NoK1B3VTVsWE5hbjJUNTBwc21qK21lQ0ZvS2lDSlZRSThTa3Nr?=
 =?utf-8?B?VXpiaHVJVFMybVNmbWJkaE1OVE1nVHlXMDF2b0lCY002bVVZbVhSLzQ0eVFw?=
 =?utf-8?B?Z0E0RkNKWU1wUXZGdXJSRXh3Um1XRld3MVp3OStDM05tN3d0U0V3bW5CQ2Z2?=
 =?utf-8?B?L0RnSVdycStkQUdmaWJVYVA3N1BlZEhLSXJySXd2V1lJbkl0NGpyZncrVnNX?=
 =?utf-8?B?b0kyRmVHSVd0Mm94ZzVZSWJFbHpYb2pwclpVTXdBMEovQ28xUWIybjlNWk9i?=
 =?utf-8?B?QUd5SnNkZXc4TWx1K2lHS29ock0yTkpwR1NBRkFwZWJWbG1YeERpa2tQc0d1?=
 =?utf-8?B?TEdRS242eldONWJsbTM5M2RsMFhBKzVBRWdkNjVlaCtaalZYRFdBbU9KNldH?=
 =?utf-8?B?SkNuRUVmUzNlM1lZT2Rkcmd1ZzhKbENVOWZIRGdTRm5QUkxmV20yQkhiallx?=
 =?utf-8?B?K1RENlQxd0RUOU1zNnJycFA2UHdhWHJUSUlMSXgrblY4emxXa2FOb0hDb3lF?=
 =?utf-8?B?Nkp1NWxLTUF1OEljeFVhOFdEN2UyTEs1TVoyQVdTdFJnTEtOSmpUTTh0bnBI?=
 =?utf-8?B?Y1BtQ1hJSTVDWnkrQURyQ3B5Sk5mcEJaV01qYU9HclRHaHRZNjlydjV0azlQ?=
 =?utf-8?B?RURMTXI0YThzZkYweldER0ZlR2daTVpvdklCdVUyaVlUanJMMFZkTzU2NXIx?=
 =?utf-8?B?MnFZNVlYcXBUVmlUY1A0bk9ETmtsKzVSWWdmTjhSbk1kYll4TmMrcWVnQ3p1?=
 =?utf-8?B?a2d5SWQ4NzNvTHo0VGVhUm04cjdRZmhIbWtPSHZqK1IwSEVqellOb3B6VHA4?=
 =?utf-8?B?VUpLSmxSbExrZ0QvK0NhM1VGK1FnOUgyODA3STNVUnVTWk1XTzlsYzB4VEJG?=
 =?utf-8?B?VnVuNVd6Nmt0dXhxRnR1Z3d4cGUrUmpJTkhEMGJIQmQ0YWJ4b1hHZUNRTVNq?=
 =?utf-8?B?Mkxma1lQNzliVEpTdDV6d2draU1MQk1yYm1jeXhjdHEwdXVQMkwydmhuRC82?=
 =?utf-8?B?Rk0xOHorRmZvYkJzZDNEOHAvVEk1dVU5QmhpZm0yeUttaHgrYVFMOStMQ0VM?=
 =?utf-8?B?Z0ZZNmFhdXBWK2Zpb3ZsSkdrLzNBUkxGdElhRktEL1YrVllvTUo0NlB4RWhv?=
 =?utf-8?B?VGNiZU5YMXd3VWg3QVhZL1pqdzc1cXNqSVhMQ3BSOXNhaHZyM2VncnUwQkhp?=
 =?utf-8?B?bWdiZERISW1MYVFZL2lQTXNYSWVwUjFVd2xoZkpvUE1EdVRZM0xGbnhFekJy?=
 =?utf-8?B?ZW83czJmYVpVcEtseVgyY2xCZlI3aHpEWm56N2xyR1Yway9QUnRPQ1ZLaER4?=
 =?utf-8?B?MDIrSjJrWG9aWHQ0WGx1S3hPSEhyV0JnZGZKUlFhVDAwdDQ0Q1BKTEZRQXg2?=
 =?utf-8?B?dHBwcTFPblpuMzF2ckpteGRHbjNPc0hVeG9pd2NoZFBVN2JpcWd5eUdubzdu?=
 =?utf-8?B?VzlpUDI3WEI1WmYzOFNBUzM4Q284bkt5WVlyNlVPMUVkVElhMUkwVnVwc0dH?=
 =?utf-8?B?dGpDSHFnTzZVWFl1NG1IUmUxeEVKM3ZCaVdFNmpwcDByZ005YXdLZXd0ak9o?=
 =?utf-8?B?ZXhGYThIUVBJZUxBQytQTG1STHJBamc0QUlUTmp0SmZMUENqY0V5K0lUYnVH?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4503EEF3D4CE8D47BB86588276E9D230@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?amRPTG9mMW9aN1FkdzRYUWgycm5TNXZlUnlKTUdwT3hYWWl4QnlSa0lkT3Vu?=
 =?utf-8?B?aHlMK000REJVTjJySnlQK0lZczJZUWZPbGpiZEVWZHVLOEF3S0x5dHJoSUlN?=
 =?utf-8?B?OFRJcVRNZUE4ZDJ3ZzV6Nm5iSXI4Z1RMNTBUSFVpSEVuZk9Pdm0zcU5Zb3ow?=
 =?utf-8?B?cUhsYVIxK0ltNlEreXkxRlZxTHlvMis5aWZVMnMraERpMkE2UWU4aEp4K0lP?=
 =?utf-8?B?ckVoUFBnY3lxYVNJWWNxU0dyekN3YVNJSVNERlgwMGNlN0pYN2pOVm10V2pZ?=
 =?utf-8?B?RWN4cktTOEd2Z1JzUjZGeW1STVVIdzJTbVlhcEU4VldtdHRZWCtFYlIzbHNs?=
 =?utf-8?B?Mm5Fb2RxZ3dIYmtMS2N4a2k5Rzd6R2h5bGVOY2w1WGlrUWtMWXNzSy9sTVFy?=
 =?utf-8?B?QVkzdXRUU3lJOE02NEx2TzdwcmtuUEYvL2tnTjlScUJsb1A3M3I1b3RDcDBN?=
 =?utf-8?B?NTVLaHVmanR4elZUV1VhbjUvN1ZpT0lQTi9zNmNsSXk1anZaWGtBUU5YVXNG?=
 =?utf-8?B?b3RsQmR3QXhKNlFsOC9sMUFHeDBESk5VczVEejVLVENaTjZVTTdiZVV6R2R4?=
 =?utf-8?B?V2FCWUduRmhlRXFxcU1oc1c3TmtMR3VkYTVHWE5uM0t2dGJsM3ladUtaWVRC?=
 =?utf-8?B?UkpISUVERzhUbjJuNVk3M0RoZXVtc1RkbGlNaGlYcTNvZTg0K1RROEZWbVN3?=
 =?utf-8?B?dWJ0RGJtWXBnWDZta1YwQmlMTmtkY0RsT1ZnTklyeExnU0JJbFp0RTJEcStX?=
 =?utf-8?B?aUZaamtSRTB1Mk5ES1ZJdVdlNmtBSWJDTFZ1SEVwVDl2Q0VBSWJmeld5TE1s?=
 =?utf-8?B?NHB3Ulo3aWlJQW9UZWlKMVNjZHpyUEFzMmFRTC9qWWJMVGFQYXlBTmp0YjJu?=
 =?utf-8?B?QUMvQWZjNDFxNUNmMi8wZjJ3cTdxN2o0U2NoeVRYVlNta0RScDVjRXRFWm9k?=
 =?utf-8?B?UTlMeTBvc1JoSG1IZ2FrTjQ0alNYOUNhN1F5R2RhWWFET3NTQTZTSFlMMThJ?=
 =?utf-8?B?SzczcUNDL0dmLzVUQVlYRCtNMFgrL2YzUkYrZnVGN1lHU0pucFNVdTlrNHJu?=
 =?utf-8?B?bm5ramhCWGVFVmFJYll3djExOU8vOUtXaTZXb2tNRklQV2RCVTFDNU1qZkZ4?=
 =?utf-8?B?VTVMcVNvY1FRN3FBNUVEa09WeEd3ZTRpdGFIVFpKQTVoZVNFK1c3MDRoUFRa?=
 =?utf-8?B?NnRoWGJKcEc1cDNIZ1J6d0hTOVRvQzJ6ZEdOSSs2dE5jdGVkVUo5RWI3LzZB?=
 =?utf-8?B?akFxbEw3eXRlSG4rYzZlSm1sdE03SG96b1BsamZaL1M4Ui9Udz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0175d377-8fe0-49c0-81e8-08dafb54f4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 02:12:32.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYsAaZaX39SND19ZVNx4qGE/MS72QKROc4EkKrEtv//9DpbzoI80ehcZS+bqtfF3X2PXGkKbRaYKiiikNnDgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
X-Proofpoint-ORIG-GUID: 3yK_v3M47-gCzgJ6WX3S8m6Zu3jo8DpE
X-Proofpoint-GUID: 3yK_v3M47-gCzgJ6WX3S8m6Zu3jo8DpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=759
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301210019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKYW4gMjAsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFNhdCwgSmFuIDIx
LCAyMDIzIGF0IDAyOjAyOjM2QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBG
cmksIEphbiAyMCwgMjAyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+IEEgVURDIGRlc2lnbiBt
aWdodCBoYXZlIG11bHRpcGxlIHZlcnNpb25zLCBzb21lIHN1cHBvcnRpbmcgcmVtb3RlIHdha2V1
cCANCj4gPiA+IGFuZCBvdGhlcnMgbm90LiAgQnV0IGRyaXZlcnMgZ2VuZXJhbGx5IHVzZSBhIHNp
bmdsZSBzdGF0aWMgDQo+ID4gPiB1c2JfZ2FkZ2V0X29wcyBzdHJ1Y3R1cmUsIGFuZCB0aGV5IGRv
bid0IG1vZGlmeSBpdCBhdCBydW50aW1lIHRvIGFjY291bnQgDQo+ID4gPiBmb3IgaGFyZHdhcmUg
ZGlmZmVyZW5jZXMuICBTbyBpZiBhIHNpbmdsZSBkcml2ZXIgY29udHJvbHMgdGhvc2UgbXVsdGlw
bGUgDQo+ID4gPiB2ZXJzaW9ucywgeW91IGNhbid0IHJlbHkgb24gdGhlIHByZXNlbmNlIG9mIGdh
ZGdldC0+b3BzLT53YWtldXAgdG8gDQo+ID4gPiBpbmRpY2F0ZSB3aGV0aGVyIHRoZXJlIGFjdHVh
bGx5IGlzIGhhcmR3YXJlIHJlbW90ZSB3YWtldXAgc3VwcG9ydC4NCj4gPiA+IA0KPiA+ID4gSWRl
YWxseSwgdGhlIHVzYl9nYWRnZXQgc3RydWN0dXJlIHNob3VsZCBoYXZlIGEgd2FrZXVwX2NhcGFi
bGUgZmxhZyANCj4gPiA+IHdoaWNoIHRoZSBVREMgZHJpdmVyIHdvdWxkIHNldCBhcHByb3ByaWF0
ZWx5IChwcm9iYWJseSBkdXJpbmcgaXRzIHByb2JlIA0KPiA+ID4gcm91dGluZSkuDQo+ID4gPiAN
Cj4gPiANCj4gPiBJIHdhcyB0aGlua2luZyB0aGF0IGl0IGNhbiBiZSBoYW5kbGVkIGJ5IHRoZQ0K
PiA+IHVzYl9nYWRnZXRfZW5hYmxlX3JlbW90ZV93YWtldXAoKSBzbyB3ZSBjYW4gZG8gYXdheSB3
aXRoIHRoZQ0KPiA+IHdha2V1cF9jYXBhYmxlIGZsYWcuDQo+IA0KPiB1c2JfZ2FkZ2V0X2VuYWJs
ZV9yZW1vdGVfd2FrZXVwKCkgZ2V0cyBjYWxsZWQgd2hlbiB0aGUgZ2FkZ2V0IG9yIA0KPiBmdW5j
dGlvbiBpcyBzdXNwZW5kZWQsIHJpZ2h0PyAgQnV0IGEgZ2FkZ2V0IGRyaXZlciBtYXkgd2FudCB0
byBrbm93IGxvbmcgDQo+IGJlZm9yZSB0aGF0IHdoZXRoZXIgdGhlIFVEQyBzdXBwb3J0cyByZW1v
dGUgd2FrZXVwLCBpbiBvcmRlciB0byBzZXQgdXAgDQo+IGl0cyBjb25maWcgZGVzY3JpcHRvciBj
b3JyZWN0bHkuDQo+IA0KDQpObywgdGhpcyBpcyB0byBiZSBjYWxsZWQgZHVyaW5nIHNldCBjb25m
aWd1cmF0aW9uLiBJZiB0aGUgY29uZmlndXJhdGlvbg0KZG9lc24ndCBzdXBwb3J0IHJlbW90ZSB3
YWtldXAsIHRoZSBkZXZpY2Ugc2hvdWxkIG5vdCBiZSBhYmxlIHRvIHNlbmQNCnJlbW90ZSB3YWtl
dXAuDQoNCkJSLA0KVGhpbmg=
