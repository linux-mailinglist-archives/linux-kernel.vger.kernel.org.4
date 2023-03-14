Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DAB6B91F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCNLoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjCNLn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:43:59 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FBD15148
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678794228;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qzZtNxHfo6RzkB7agZSgsWYLVxmosjA3fu6qR0J2Q+M=;
  b=GvsG5QJWwCOlXZeNkF1MUXsbJji1UDjm6+oRRxI3Kq16xj7NepLmWybV
   1rJVb1e6XyHEZcnFRS4qweW9XeB1o8nLFlbImVMoniC0/VYupK5czwzOm
   TtbUIXge+RY0AUBFsqX0zV6mejEpvVp3CfBO1XfY7jyGIST9BvnUQYqBw
   o=;
X-IronPort-RemoteIP: 104.47.66.49
X-IronPort-MID: 100768011
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:0Eqtpq+R7u0FF974y83IDrUDYn6TJUtcMsCJ2f8bNWPcYEJGY0x3y
 2cYWjjQPv+ONGH1KYgnbdzl/RhXuZbTx4drSQFppH08E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ire7kI/1BjOkGlA5AdmPqkX5Aa2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklPr
 8MVMSosSiqv2fKSh+6pU+tlvdkKeZyD0IM34hmMzBn/JNN/G9XmfP+P4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTaNilAguFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAuiANpNSu3gr6cCbFu72lY0GUcIXGOA/ODkr0KwZcpiM
 EIS9X97xUQ13AnxJjXnZDW6r2SDpQU0QMdLHqsx7wTl4qjT5B2FLmECUjdbZdUg8sgsSlQC1
 lSJt9LvCyZmvLCcRTSa7Lj8hTG/OyI9KW4EeD9CTAEApdLkpekblQjCQ9VqFrK1yMf4FT3h6
 zqQqyEyjLIWy8UM0s2T907OhTu3vZPJQyY87QCRWXiqhitybZSjZoiA5VXR7P9GaoGDQTGpp
 3EYm9mXqvgUBJKEjyylSv8KFb2i4PPDOzrZ6XZ0ApYo8T2x+zu7Z4la/XdlOU1zO8MNfz7Ba
 lXUsA9a45oVN3yvBYdyapitCsJs1aX8GM7+W/b8acBHaZx8MgSA+UlGQHasmk7wi0krl4U+P
 4qLN96gCV4QE6NuwDGxQqEW1rpD7iQ/w37DAIvw1BWPz7WTfjiWRK0DPV/Iafo2hIuAoQPI4
 5NcOtGMxhF3TuLzeG/U/JQVIFRMKmI0bbjmpsoSeuOdLw5OHGA6F+SX0b4nY5ZinaleiqHP5
 H7VckZUyXL8n3zKJgSRYXAlYa+HYHpkhXcyPChpOEny3XEmONyr9P1HK8pxeqQ7/ut+y/IyV
 +MCZ8iLHvVITHLA5igZap7+6odlcXxHmD6zAsZsWxBnF7YIeuAD0oWMktfHnMXWMheKiA==
IronPort-HdrOrdr: A9a23:+r74Za6ZXtfEY0DnQgPXwKvXdLJyesId70hD6qkRc3xom6mj/P
 xG88536faZslwssRIb+OxoRpPufZq0z/cc3WB7B9uftWfd1leVEA==
X-IronPort-AV: E=Sophos;i="5.98,259,1673931600"; 
   d="scan'208";a="100768011"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 07:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq5OhSlt+kai74kmXM+E1ukbvgBP0owXI6c2Ns6zKqCbcOZmbx0oYFHTpeVVthUKXzPOJ+jq0D/AM7QhVAGJpNpUoy5XlbKl3XAXnawXMcEAS2B7rv/xWTeuR8w91ljWBJCcZTFDJuCu/DEtFckZjK6UvQ81t6tfvV5A3QL/yGIK0FkqhgITL3w966OX7DBWmuuov/RGfFPmQ8P4r9YEhiMW6KvUpdfiuwad+y1TLk6X5WgBuQ5P6QDIbsHtwT/C6WPKK92AKCcyoKCLP/zqKkNO8+w6hlyzzT/97v+hiODyIB4Fy4m2vI7rJn0EQDZTtCorjdthOQaHI4CZSeTPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzZtNxHfo6RzkB7agZSgsWYLVxmosjA3fu6qR0J2Q+M=;
 b=U/W5uCR73n8G+eNX0YFmYQNNyEBO8lV8PEgmUK8MjSfxY/iKIbfEysDHfzmnBIa2Q9l7uIhMabNpFnZQ3YUemzNs8+dw0FAxhT9DcylADpCy6SGIeHyY2xcrPDIJpiOpRTycRNx3dLtPVlRSKzdghYpSb0q4AfSDxFeHXQ4NH5O1r6afeqY8VpyZxWSXfr5M+1LLT7Hh0o3Dg6OFi3zS8uEXz+6JstxNxuOurUC15TdCNortfZg4hh5i9Vz7DAtyw5UHpW1kshdMNIlYxKcBpAtinAV6n3BdDXwI6btfWhglc2M8QgOg1XGB3qS+waUGRWVd1/5eyLBiuy+R657G8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzZtNxHfo6RzkB7agZSgsWYLVxmosjA3fu6qR0J2Q+M=;
 b=Q9wk6d8NdLhiGD88tWzvTYXWr1nljd7+I3NVJLSXOaOcFk82Mz+N8+340bffBiSlmshzyBDo7vcxsWjo2zdxluyESf/eH64x9PmMxTtC+cQccAE9EWEoDY5RoAORvWZpyt7+cpMPSuWZZVH9z85TcElQ5DxXjO4PPZF3UBM+r8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB5701.namprd03.prod.outlook.com (2603:10b6:510:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 11:42:15 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 11:42:15 +0000
Message-ID: <8cc36c16-4aa0-9c47-ab2f-c75c1e22772f@citrix.com>
Date:   Tue, 14 Mar 2023 11:41:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Content-Language: en-GB
To:     Juergen Gross <jgross@suse.com>,
        Joost Roeleveld <joost@antarean.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     jejb@linux.ibm.com, Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
 <30a056c8-071f-4259-3253-75e718af619d@suse.com>
 <Y1bEQMS5SNTbZO/3@infradead.org>
 <858a4288-46ac-d423-a529-b3b77b7fbc8a@citrix.com>
 <20230314111752.EGroupware.TiNRv1BSroWqKL7zQtfNLJ8@_>
 <4c5de098-5cd3-116b-54cb-6972c6c06818@suse.com>
In-Reply-To: <4c5de098-5cd3-116b-54cb-6972c6c06818@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::17) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH0PR03MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 21aeb820-72fc-4bb9-676b-08db24812860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yja8lMIF6Nxrujrchb8MwHYGQg/y33oyKJQu+kyu3+rJVMamBHAXpf08Dhb7jJeufxUws3E0D7Jui6sx5qJTTeHtVLuPr0lCJrV0BkoFPxW4r0DEHNUHLIqVPY+20cx/SFeOjntOyWLf8Hnz5AoYMjZ8Cp/XTCSoKjHysVEd0/u+1lLPa6tkV3P4LZVRjvDSpfyfj+4BWw56YwXTv1jHyvasXBQpDn+tBxF6E8XkPZMW4CLFJWJfn6opqMrfUZl5821wZaUZ3bOEIw8EGfkVRIEXyDMDw9caFEohRRG8XBsA+8t1pgNb1AY29M65RotLCrZScQIKaMy2VPZ03bUY88zRptHR51k/OJNc4y4+j8jLRO43ViYIjHXF5hFF/7I1foX2GK4QiYQ490JLdMTU8GDiL9c1Eu5VRaKoIQOvZ/+jjJV/A2jUUR/XGnpSn9v6WMq8mtzDx1U1IGgdXb83bnex4p0vks9lhjPBwuNitktzayuSDxtyZkef3USrlMF4Nucfd4SGfJQr5cblBG1eWGwvWF1W+ik1y/gZo1SXwHCEZ33AYgt7heUt8en/h1S612z8S96FBcCXOsYu4RUuT67PwOAW0VI2sX6ax2Ubt9Rk69IA0fNQGMmddXqcsgIh4a6B0+r6c2jXkhALYdHCNwAFTi+0eMrOOtUABtJAuK1OE5yjQ+pHoTbCHYrtaEyRYjZxYsI5/k9lIbec7TEKg0VprnlWloDw9aEgxHolRs9bDUj8w+WyP0SchVB0hfXsrlFsKYHPkJyk01cF5+0gVWOtdwp2lh2cajlG3L6vY3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199018)(6506007)(6666004)(26005)(6512007)(36756003)(6486002)(38100700002)(66556008)(66476007)(66946007)(8676002)(4326008)(110136005)(478600001)(82960400001)(316002)(54906003)(186003)(7416002)(2616005)(53546011)(5660300002)(86362001)(31696002)(8936002)(41300700001)(83380400001)(2906002)(31686004)(42413004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3VaMGpnQlBzK1l3T1ZPWE02L3QrWWptbU5MbWUyMEtCV0syYVRvUk91RGc0?=
 =?utf-8?B?aEE5Z0E1K1Vvd09tazVjdE1PazdkNUQwbUo2LzFrVWxIaTlkcFJJVkF5S2NI?=
 =?utf-8?B?K1pBY2wwWnd2aGcybDZ4Ukw5YzRVZW90SVg1VVNSeUhDVUhWVDJRT2JzbU5s?=
 =?utf-8?B?ODMweTE5NThwSnVlMmxXK09wdnc3TUgrU2FEV2hySlRKcnRTVTd0LzdtSFJZ?=
 =?utf-8?B?cVdOK1pnL1dMQmxtK3N6VnpzM3VoSlJScCtkMkFIMVdCemh5SHcwTGJTNXpD?=
 =?utf-8?B?eUdobzYyWU9NUGJ1ZmFzK1ZuRVpDSFFycXc4Y3JkTkRkRE5ySFloWERBU1pK?=
 =?utf-8?B?UjFUN0xaRWF0OUZ5cmZ2a25ROE12ZVhVZS9SRUtGaGM0aGhLYXVScDdlSVBx?=
 =?utf-8?B?VExaMTY3dkU3VXk3UE5CY0lkdCtzR0hHVVp5cGFTVlNYdzFRZGFIV085TlNP?=
 =?utf-8?B?Tm1udGZNa0R2dk5oSmdCRitXazFLcC85cTlYK1R5MFdoL3FlMDFHcStCUjdt?=
 =?utf-8?B?aGVDTCtVc3I3V1F1alpXUTlFMGwzelhFVDQ2UFQ1MVlodkJPZGc4VURpcW0v?=
 =?utf-8?B?SlFEbmtBdDlvbWNNSWJSV2NIS1N1MENXNFVMcWxqSmJBVytTOVhleWRjYXgx?=
 =?utf-8?B?ampycTdhcExTeE01K2E0V3ZmeVZqcU1vUWkrc0ZVUFpjMzcvSUtEQzdFcThj?=
 =?utf-8?B?Mnppek5JdjJsVnlvc1dlVVRpcGprdS80YkFHVm9RaXVGZjVHcFlQbEVPZFd6?=
 =?utf-8?B?YUZ2NVZ0aDNnN1JIcnM1VGcxVGFxQUZHVDA3dldrYmt2TjQrL3RZdUhxM2sy?=
 =?utf-8?B?VHJObkRmU21kQ1d0NkxmeTMwVWI4TXFMTnllU0pyMXZ0MndVS2JyaGNMYkhE?=
 =?utf-8?B?VWFTN2xsbEx2WTZPTGJSVUxrVGY2WC80MWRINlg3SS9VaTJDL1diNElBaEJX?=
 =?utf-8?B?SEhVUDZUS3dFR0t0alJzZlp1ZVk0WXQzYTYzdFNabEhqNGpJb1BxUzZ5L3Z5?=
 =?utf-8?B?VWZJVks2YUVJK0pvQmZLZUsxTElFR25hTXFRYjlJbm1pcnFONGlRREhyMkc4?=
 =?utf-8?B?cnl3dFdhaEJuNStaNkdSclczMVFUdUErSk5QckVVVThOa2JVLzE1K3hSTmZ6?=
 =?utf-8?B?OVBXQVlObHBZZnUrOHl0djB1NVllcUw5andQcXl0R285UWpFR25LVEpXa1F1?=
 =?utf-8?B?aHlyZitjbFgvQWcwMVJFdnlVdU9YOS91bXBUeVJVdjArQzUwUDhJWWs4TXd3?=
 =?utf-8?B?QWhWdXZwWjQyZm9CRDhabXdKY1BwdmdWWHg2UWZaQzhrQ0JNaG9Ob3Vuci9q?=
 =?utf-8?B?TlEzRXpSS043dGkwdTBjdkRmeUVvRVd0M09MZVN4a0NIdGxaUWNMeEZTNFFm?=
 =?utf-8?B?WS8rTG5MSlROcVkvVjFvUzF4Y1N2QzdHRWU5eFlxcnlTejFiUXhTa3UwWUI5?=
 =?utf-8?B?U01hL3pacmdGbjhobE1MM0R5dFdnaXdLSUs1MkNOcjJrTk5aY2p5eE10NE83?=
 =?utf-8?B?bDZSUzQzMWkwV0lBSlhoV2YwQlRLeGF5amZKdE1aQ0hiWHhpYk9BVS9FU3pI?=
 =?utf-8?B?T0YwT1JkR3ZBNm4zT3J4NitWaDVsYTZBTStJZVB3Qm45S2d4V3JOUFYvdDht?=
 =?utf-8?B?ZytZbXUrVXpBaGZVTzFEU0NvK0FPK0k4VFRBNHZZRlk2NFp6cWkrdHVKby9P?=
 =?utf-8?B?MWxMTUg2bnBvcU5HbFd0L0podHNQd2lpRkVnaVNlbGc1bzNGMmJJdUNUeXVZ?=
 =?utf-8?B?VGREZnAweE9YeVRLTy9oUVdrN0tyNHdDR01HZi9iWjN2eHE0YWJBeVdOWUx6?=
 =?utf-8?B?S1JlSEgxSW5JeFZLdXRVTjVPVEc1d1lsYVdFdkR0K3BmT2JTV1RBNHpUYVVz?=
 =?utf-8?B?M2pqZitwSFNpR29zT0hiNWpGQ1ZYem1kQnJQMlluNkkwajR2OHE0cHB4TWpU?=
 =?utf-8?B?WXJSbzZxN3JTR245V0VVSXFxVWJUbGxRRm1qTm1OdU5EMSs4bE1TcUFJZ1NN?=
 =?utf-8?B?dXh3NWpQUyt5ajZGV2VDSjV0T2M1dWJqSWJhWFZxMUpDQ3RlY3NibFVqeEFs?=
 =?utf-8?B?bWNKVFhyNDZ5d0orTmNieC9Ba1dkbDY3STBSeEpjTjV4S3BhRndzSUpTQ0FH?=
 =?utf-8?B?Y1htTlFOakd4MnFOSUovdmxJakh4ZWF6US9OeEVNcGNLY2I2aWhsd3RzbjB4?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NENvM20wcDd2YUdtSnptY0xnOHphTXVYUWxxLzdxSWtOVXdHdmR3KzRqemJ3?=
 =?utf-8?B?cnBNbjBodWdibENvL1NwQXhnU1I4ZWNhRmFrUnhZbXVSczFKaDVMMEtDMlRU?=
 =?utf-8?B?RU5ZS2d0RWFMWHV4b2VrREhFbU1nV29JdURsb28yYXpOYktzWHVRcXBkTzZH?=
 =?utf-8?B?enl3RlNySUlESmZxbWJhdjlrNE90YjBSemlsNE8vVUtIT3oyQUxFRFBkRnY5?=
 =?utf-8?B?YytWOUc2ZjBsei9aczR2cm5PS0hTdFF1VEplWHBHV0dkblNFbEhoRDFnbDBH?=
 =?utf-8?B?bExFSVVvSlJxQUNzZWI1VUtoUm1lZVpSU1Q3aEdEZWlldGYrUGt2azlsQXNt?=
 =?utf-8?B?NTNJS05oaVJPUFJHYUZkbTZGUDJueC9wcFNaOFdKTG03NGc0Q1AxclFUcDJJ?=
 =?utf-8?B?WC9kb1hxbTJ1enJPSUMvS21xNGs0WlZwUlV5bEdKMEYxV2FBeUd5Z0VnWGZI?=
 =?utf-8?B?aEh6SGlSNkY4clN6cnQ0ekk0ZFR4ZzNWb2t1QjRLRzNiT2RiYS9GY1BZYjVM?=
 =?utf-8?B?NUk5aE5ETnFmbUZFUmFGTHVSSlZ5NzZBd3h0NFNhZDRlU2NPWFp1amtLaStj?=
 =?utf-8?B?LzYzb1pBU1FJclN3WlNjT0t0UGdsOGFDdFFSTDYvVk5BcDFld3g0ZFNjY0l0?=
 =?utf-8?B?QytxV0pyZjg2SURKelJIbVoyRU53RXVXam9NQ2xWTmEwKzJ3QWhXWTV3clJp?=
 =?utf-8?B?Tk5wUW1xVHc3NkRiS0RlcnViYTJJWHE5cldMQStXZjg1c0cyUDBuRWVXSWVF?=
 =?utf-8?B?NWRLMzEwT3htQzZUU2tLQTQzUFFHVFg3c282VXBGQUhFUFU2N253Mk9ETktI?=
 =?utf-8?B?ZVhUT2dta1oycy8wZVdTL0pYNXBhVVAvUlVyV2xMVkp1b0dsaWFmN2tCeTBo?=
 =?utf-8?B?RmEzRVp0Q3c5TVRIc2xCTFVLOElSejRCckQyeVpDQXNXQ3l4QmJHNFgrV05v?=
 =?utf-8?B?NFdFMThoRVNqOUYwSWlBN1RUakVoWnVuTFdETXJoZnNGUWF0MXVnM1dqRmJa?=
 =?utf-8?B?d3pyS1Rpa2hxaE1jTjhqTi85Tk0xSU1udk9mU2FlVTRnS0Z4WXkzRkNEMjBF?=
 =?utf-8?B?aW53dFNycGNVaWN1RVQ1dytNUGdqZXpyTWhqZmxlTFg3UnRtMjkrZjF4bytC?=
 =?utf-8?B?R0xnSTdGRzdQL0I5Sm9pK0tsOTZ1WFdGLys5Y1Z5NkNPK2hNelF4VWhKK05S?=
 =?utf-8?B?WTM1eURzZlczT3FMU2ROS1VjVmlYdXRnSktwL1U0a3cwNjJ3WWpJdlhxVWdV?=
 =?utf-8?B?YXFNUWFjamp5SnVBS1lMeEhhZnZUYzJsSEtwaDlRemJQbzVTT08yVk0vb25N?=
 =?utf-8?B?K0h6aHBTUml0Wmw2TkVGYjR5Q3d6SnpodEpwV2UrZlRheEl6N2VRQUtObXVE?=
 =?utf-8?B?U2JUVW0ya2lnellvcnhybUtjeWRFb0ViUkFMRGlid1pyWWRySllQNTRBNHE5?=
 =?utf-8?B?bCtLN3BheCtBZkhBNkFpNWFYZjIvN3VBRVFpWjFlVUFjcGZrbGR2Y1d2ZkRw?=
 =?utf-8?Q?AaGE40=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aeb820-72fc-4bb9-676b-08db24812860
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 11:42:15.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJTz+dtHUFWEXx9vPf7NEI1cl7HbDYHx0xe7zch64ithjwuSgR+E/sEkZWgwwcZfP6ttOAYgso65urixdBgpJQ0TbACYk7jUdBih/pM5sac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5701
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 11:23 am, Juergen Gross wrote:
> On 14.03.23 12:17, Joost Roeleveld wrote:
>>> On Mon, Oct 24, 2022 at 05:28:05PM +0000, Andrew Cooper wrote:
>>>> I don't know exactly how this translates to Linux internals, but most
>>>> devices are fine and it's routinely the mpt2/3sas drivers which
>>>> encounter problems.  It would be lovely if we could get to the
>>>> bottom of
>>>> this for once and for all.
>>>
>>> So to summarize my two mails: I think te use of dma_get_required_mask
>>> in mpt3sas is wrong, and the dma_get_required_mask return value from
>>> xen-swiotlb is also wrong. Fixing either one should fix this problem,
>>> and I think we should fix both.
>>
>> Hi all,
>>
>> Is there anything that can be done to get this fixed in xen and the
>> kernel somehow?
>> I keep having to manually patch the mpt3sas driver to prevent it from
>> being able to switch to 32bit mode each time I upgrade the kernel.
>
> Just use 5.10.173.

Its still broken even in 6.1

We've just stumbled over this yet again in XenServer.

~Andrew
