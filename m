Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CF72147B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 05:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFDD2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 23:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFDD2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 23:28:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD00D3
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 20:28:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35434gZQ028418;
        Sun, 4 Jun 2023 03:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wiftoDOoFlHJUblTMeg67u25cHOK/tsD75l6CaecKvQ=;
 b=xbzJP6sdgZKjPQ4Bsw5BHCKNIbll0bhY9H3gfuuWeLvREemAU9yEnTIque6CX0xQQZ8b
 ruDDSkCv4mQ7/vWw5IZUteYeCct+jHlnILB2dX5Y7TTSC+7mbSOcOwtMKKTrIBGEb7Zd
 XAerOwc8YPlRJqc+hAwxaiTqCxa4tDOgVmvjp8i5d/c6pPl2J1/wUG2vb4K4JQcxkON4
 UKTX2BxpdmRaazZr3DjTO7rjOFh9kUsv+Iphzf0Jx4/EDE4LretZSc/YIa6m1EKWg+tq
 WaKiEgU3UBIh2tu6d5ejYU+wkxCB4IQDnAO+Pqrpmc1t2+S48d9IsEQaXEvGzyWS2zxZ Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx5eh08u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Jun 2023 03:28:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3540ccAa035263;
        Sun, 4 Jun 2023 03:28:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qyuy86hrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Jun 2023 03:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAPQAPaltzWZzKogvxdK38jLtgR0K2aojWU75m5LSMvOqdtpEVSrIpWJQNRZ4H2eYgyaQCprXrCZAr5cJYTts3ZwBjyE0lOqQbhLQYP3SffEPptXFh5JCsJJQSWqTKdNtHkqb5izYXLHZZ7pI9eGJB+D1B/Cnv5xYipx+TJvs5aVCGwTLPbTlq35z45zB9hgAutOjKdvtWN6rL+9lOKUX7TIck3pZ7jvj7yiuCyrmZaHARNNEKIrrrNZG94Rv3/zmNq+O/pvdzFKh2g3HeOziRNFJjnJNa3bEWGgaV4PRXKRn24eieSBtegPX6acPhQWdHPYQw5LQG/TiwgWMk6x4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiftoDOoFlHJUblTMeg67u25cHOK/tsD75l6CaecKvQ=;
 b=FsBHUW+c/whak3A3xhlcsDLNER8osNmft3PivgsgS5xUekwFP4e1HL/ZRgQBxSnPEyFRDYnTZSE9ZeS5L52GECS82h2fw10Al8/I3nmKULfOf1dhN8udo3WfwGQB16RThsdBPQ3Q+XecKD4PmAe0Mj12OFwLnplketL2W2zCbi00X0MFIgtBiP6aIb1/m9fbq9P5hNcv7hYtN7YPLcjzuxvbVe3orjZx0RZenLrS29ebNIXIBuhARD6SM60UFLwhMsHevXambscWevj1t75oM3iv/lBUbR4shD4uLtiTrQHipGTWRJB9Qp2nN14Yx8pALDMIhB1UJZxQg/NJrOkoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiftoDOoFlHJUblTMeg67u25cHOK/tsD75l6CaecKvQ=;
 b=bJJdqAPFhxPgVl0W6Xc2UpguTyW0wYp5JRjzIFtZYRM6VJcN6ka78STvAiuNek3JGMJ9ICIzVAZ/wjcwn5hVVqttK+uQXaD+kI3U63U27zwa7eyDfBi5qIWCJJOVvwEsCbC54rl/W1lkxUK1FMGJYBY7AiBWvvSWbtC/oAxvm38=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sun, 4 Jun
 2023 03:28:27 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.028; Sun, 4 Jun 2023
 03:28:27 +0000
Message-ID: <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
Date:   Sat, 3 Jun 2023 22:28:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
Content-Language: en-US
From:   michael.christie@oracle.com
In-Reply-To: <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:8:54::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 73df279f-09b8-4c48-f11d-08db64abc25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiGCVHiT9kfMAH7x/83GvVbCDbdgX3WG4ZQt9JuUbz+kZEvg9xpUOJWSt/Ggwpp75Yv6MFVUQLbBEce2IvB17rTWC69P+ZuJqOIEgeXrmlfOnRbZH2cZPHI14qEv9TP41jaxtMZQeLUeST0plgimOlAeMpIkaUyJRnk/caqrBPRtdSfkvhCAUT6laGmRi+H3eh9d+2RoAPM1UHm3vGFGZWocmKnh5ONoSGKU83oYOa25bmJq+3RmBoUq4bJjWBPTyLE29xyFSGG9K9CuFuFy9k+h1Ifn+L0FRnAgy3cR/3uBw9BpURaVNvm7BnIi+byvOKVsa8QuBjDJZ7Ti381TWooV24E6GRh1fFqq9lOqjZIoFoXSaV5xRBKCcw8nnCxzEp/aeZw4rbcauPUXWQw8gYNX6twwoDxuKhXMeP7V2/KturWZu0CyoB/7lLo5Lh/GW5nUzcavCriQsLH17HbL1j67pXxDn6MAOSSgKsMx+7kkfWc3CkqLKcEpR1nIpzzysOgAjP6ugU4XDm+7jdfUQfVNLU2kE3lusYzVOFqP54wic4TVtgBsDAIR+bZnIO0D/ESvahg5czK+3vxnrb3tK8guGyudrd6s5GU364q0yfRjOytZujsIRibTAD7UDYqU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(53546011)(316002)(8936002)(8676002)(66556008)(6512007)(66476007)(41300700001)(478600001)(38100700002)(4326008)(9686003)(5660300002)(26005)(6506007)(66946007)(31686004)(7416002)(186003)(83380400001)(110136005)(36756003)(2906002)(6486002)(6666004)(2616005)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpZcVBrOEhZQzFBalJxYTE5WVBNQ0RoYkNJd1hJZ2tyN2tUUDV2SEYyWU9L?=
 =?utf-8?B?U1VXblNONkdsaW1mbnNnTzhyOHBxYzdWSnpuTzhYaGRKRmM4UUxJT2JrZDNT?=
 =?utf-8?B?RzFxT3g0S0RpVElnNThtTkJJRmNnNldRTW0vUVhoazcwMjY3VW9LSXh1V1RN?=
 =?utf-8?B?S1l6cGRGM0IxbEZtdm5XSXhORXJuY0ptZm9KTjd5a2tnMTBSSmtyMlRkaW5P?=
 =?utf-8?B?STd5NkdoaHVXQWVIUzlXSzhEekVaM1dZSXVRUHdXWFlwU2dVZUxTVnhqUUdC?=
 =?utf-8?B?d3IwYUtORHdEMm55S014dzdVa3g1UVYvUFdqNjU4TEZxK0JrNGtYMXJhNExK?=
 =?utf-8?B?L0N1aFBLNFZIQVdKeWNGcmlXY2liL24zRm94ZE5pekVYMWZjc0VEUCswSmpa?=
 =?utf-8?B?Tk5vQlBXMDYzUWJDZjE0UkpUN01nbmd3SG9LQTJVZlJYRk83R0F3Y05hSVRR?=
 =?utf-8?B?RFNuU0UrNmtIWURURHVTa2dYRXZnQUYrWUEycnlqVUtSN2RDZTN3SEgwcEdF?=
 =?utf-8?B?d1RLajFBeVFBeTlMVTdxcDB3MVVnc0pYa1NpZE1yUERxK1NTbTloalB2TVBx?=
 =?utf-8?B?V3hlZUc1dkdOUml3dytZcHY0T050bzR4TnNSbkJxOWc5NU0zck5PZmtXa2hI?=
 =?utf-8?B?YUo1YzF1MUVUa0t1ZC81Mk9QVko3ZVFrcW40VFV0QzRuUzlkVDVFSHRqZldQ?=
 =?utf-8?B?cDhUOTh5K0VYelBBOVFsVW1YblJKOTVIVWV4NTRmM2Nuc0lTQVAzT28reFNz?=
 =?utf-8?B?bFNINjJ1VmpvMnM2REg2bWVyS0w5MHVmeXdxZnRrRkFnTXZ2VytTcTNJZTRk?=
 =?utf-8?B?UkMrdEdQM0lEdVZqMmVyUVcvcWtmdTVISUVCelFzQ0pJUzdhdkFjaUhRWkpH?=
 =?utf-8?B?RnlkVCtxeDlnUVdXc1YxWkg0MURudTh5OG1UQjE4emkwS05ZV1hwMnFTT0t4?=
 =?utf-8?B?cGNFU3dncG5XL2FhdG1saFhSRmNNWi81R0hwU2dXMjFhSTd1elZRWlgwVzJZ?=
 =?utf-8?B?ZU12Y0hlb2ZtYVJoQkFuYnMxYTM0TXJ2d3VvREtmdzdkcmJPcytLbi95MVZo?=
 =?utf-8?B?Ny8xaW1TNHE1K0o4NWhaMGplekVydXFaWnJlUXZFenJ5UXpQN3RzL0VpNWZo?=
 =?utf-8?B?M2tkck14ZEFWcnNiMkppWE1hNXF1RnJMTEpXMTF5T1BJOXlZQnYrMUV5L1o2?=
 =?utf-8?B?dEo0RHI0RlRtNzJrV2ZBRUE0SmZFSlczUVFHS2pQak9TVXExanJ5dmNOS2lm?=
 =?utf-8?B?QU5tcjNtMlQ1STdycXBnbjVaR0RwMEI0bVZhL1VReUlLMGJMbUIzeWg2b29n?=
 =?utf-8?B?aGdPcGhRdEhjTVl2NXJSQXJOY3cwSHNTV2xFREJJbDFtVHZydG5HMkR5Q2xq?=
 =?utf-8?B?SFhjTk55MHF3VjlCWkhFTFZIZ2h2WGxpcDJOOHUybkhTdGdDT0xRMEFrTUtY?=
 =?utf-8?B?MEZsK3kxSkdsY2lRNkE0ZUsxZ2VSMnRBWGxMUTl0MTZrUG5rM0ZCc0ZmeHhC?=
 =?utf-8?B?RldHK2dmcHd3Rnh3bVFrVGZ6OURXeVR4UVY4YjBhUU1RaVRUNUpHQk1CMGQ2?=
 =?utf-8?B?TmxoRlJwUU1HQnZOVHRGMC9kQmxmRndZaDI4ZTgzSjJSZnpUYkY0dXRzcUF4?=
 =?utf-8?B?aVJGTGVnT2hVeVZOU2duYlJjNDc1TVhmaVA5Z2gzSEJyMVpma0IvV3pzRGRY?=
 =?utf-8?B?YXg1SnIvWlEwVk9WNmV5WWIxTHJZQzVBZkcwNGRDYU9qR0JObVYraHpQdTM5?=
 =?utf-8?B?a3V2OU5xTlZmSCtxZSt6d0VKUjIwKzM5cVQ5S3FkQ0xUbWNBdHk2UXh4amVx?=
 =?utf-8?B?QXFHQlc0K2JxSmJZSEZsNmRXWWFDNW9PeFpmQkxBbC9Tb1pmYU5XeVRQcGp5?=
 =?utf-8?B?aGJ0MGcyellNMFp4ZVErOUE3L0pOTFFaWmNlcWNHT1liZmUrc2RZMGw4M2dY?=
 =?utf-8?B?RjRjNUhtNitETHNtWjdFdEg2RS9sRXcxTWVCNzgzZ0lOeEx2bGh3NW0wSGx2?=
 =?utf-8?B?ZjlJQ285UWV1NWJUR3l6WDBMYUFGVFp3NTlwOEVpcTZ4QU12bk00ZXBvbDB4?=
 =?utf-8?B?MDBTcTZnbzBpaDFrSktTVWlld1ROcGNBRzMxU0ROSnM5WisvMjI4RnQ0MDVu?=
 =?utf-8?B?cndpSjZZMzMzRmYyNjJpR3hpbEQ5elJ0UXhWbUZCUUZnaHgvTDYvWjZBdjF1?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y0M0Y0xuNE1RSzVOZStweGhWcWlPTGVLaU0wUGpSZVlqZHB5RlhSdVdIZ05i?=
 =?utf-8?B?UTIzREJrRDlHR1ZrakZNZjZ6QTNOTEtNQU02WTdTQ2FDM3FNb2Z4N3V6dmJD?=
 =?utf-8?B?dndtSVNMSEpwNzRIQWNSOG1VY0V2VEc1S3NoMzhuMkNZSmxDQW94WnVuS1Bv?=
 =?utf-8?B?MzRBd3JlNFhrbytqdUpmK2Mza2M5SXRsY0gzSXZrYkFRVVVWTE5ycG5FUVZm?=
 =?utf-8?B?MHM2ejZ4NXdOY2R1V0J4TEFsMFdUbzlnQ0hSN2hwRXZlb3B5OWJySjBKbDE2?=
 =?utf-8?B?RWJGYzF0VXJXT29hY05FUnIzY0ZJUXJ6bjlBU1dPTUUzYittVVUxS2NsMlQ5?=
 =?utf-8?B?TEVFUFpjK0RsditWOTZZbGRweGFBcGhvbHpGWTFnZDZ2ZnJlQW8wMlJUcGNx?=
 =?utf-8?B?Yk1lcjVEV1Z5WVJHWW5UQjNLaVpnY2xzMWVWcGJhL3daWmg1dUZhUC9mOGZy?=
 =?utf-8?B?U1V5NTcvTENHMS9Eb1dZMGwwQWlqOGx6N1RaWi8zc0lXalFZK1p5dVZSTGlN?=
 =?utf-8?B?cEVuWEtTemtUT1NXeWJCK1d1RDVkdG9HZ3pMbUFLWXkxZ0d3RVM3a3N5Y3Zv?=
 =?utf-8?B?UmFrOHJCV0FHSkFOeHFna0VOSmttQkZWcVpsT0thY1QrMVpxTzJDTDZmcjhw?=
 =?utf-8?B?bEtPbk9FU1VaRjlOYlhXbTFmcTBCK3dxamRURmhvbGRFbmoxb1l5RFVkY3lX?=
 =?utf-8?B?ejBRYXdMd3RkOGtUZm9MOENHNmRNUEg3QmErUkwzcklsdW00bDJyNDgrL1BB?=
 =?utf-8?B?Vlh1SlQ5NEEwemExMFF2aW5hek8xN1Z6NjB5ajIzT0I3WGtTcTNoanhyQTdF?=
 =?utf-8?B?Z0FHMHFsS3dWcm96YUJsVkMrbmxWc1daOFBETEQzZGtqdDh5OVRsVWtKdjZH?=
 =?utf-8?B?S2ljT1pJRDY2MnFpam5LcGxFbkZVc0RmTk4wNXRhMndOUTg3cHNJRDU2aHpl?=
 =?utf-8?B?d1hJNzFPbStBWUJCNVpBelpXSlJiREZFK1AvT0dhRVVOT1Y4WFhwWDdadDUv?=
 =?utf-8?B?NTNQWEJqOUp3SzRVUnUxSTVmVVBuZUVmUmpmY1E0M1pNSEdnZlBLbVBQUXJZ?=
 =?utf-8?B?cHBQUEM5SWE5dXJxdmM1bEJpOXFZREZ2NloxTmFzOXJPVlp0S0dNYzNrbm11?=
 =?utf-8?B?cmNKY3hSMTVTMlhrWTZFSmxVWWNKWG9qd2UvODU3NVFobzVOOE5sTE80cDJt?=
 =?utf-8?B?dEM2d2UwQWJUZ1ErZzVpYnBMMlRCYUo0Z3d5c0RpakUwMnl1VUVkU2lsRGNL?=
 =?utf-8?B?VkI5SE9OR3B4SkI5RWI1S1ZIYWVGaVJPVmZnMFpBUEZMQmdZNG9SSTBlRGZI?=
 =?utf-8?B?N0VoZjlzaHdHZkpWamJMbU9SU29VTlBxbzlnUG03c0piM0pjYkVUeXJtTlVU?=
 =?utf-8?B?ZlV5dGxibWJRNXQ1SGp5aU8vbjFiZkdMblNwQ1lTNWY4eGJtcVAvS0VsQzlp?=
 =?utf-8?Q?JpWMECwg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73df279f-09b8-4c48-f11d-08db64abc25e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 03:28:27.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk0KE5tSTD/0YpnBZgOZZI+3MU1VjBItUrocvokumOWVHt2r0WrzKXLVZ1TuBPov+b+7WJEhe7qKSsoeLWXu0XewfvDbPNqDTMlAoHyWZzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=945 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306040030
X-Proofpoint-ORIG-GUID: vpSKbUpZK7dM-BVRSK85rapz1XaCH3RB
X-Proofpoint-GUID: vpSKbUpZK7dM-BVRSK85rapz1XaCH3RB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 11:15 PM, Eric W. Biederman wrote:
> 
> This fixes the ordering issue in vhost_task_fn so that get_signal
> should not work.
> 
> This patch is a gamble that during process exit or de_thread in exec
> work will not be commonly queued from other threads.
> 
> If this gamble turns out to be false the existing WARN_ON in
> vhost_worker_free will fire.
> 
> Can folks test this and let us know if the WARN_ON fires?

I don't hit the WARN_ONs but probably not for the reason you are thinking
of. We are hung like:

Jun 03 22:25:23 ol4 kernel: Call Trace:
Jun 03 22:25:23 ol4 kernel:  <TASK>
Jun 03 22:25:23 ol4 kernel:  __schedule+0x334/0xac0
Jun 03 22:25:23 ol4 kernel:  ? wait_for_completion+0x86/0x150
Jun 03 22:25:23 ol4 kernel:  schedule+0x5a/0xd0
Jun 03 22:25:23 ol4 kernel:  schedule_timeout+0x240/0x2a0
Jun 03 22:25:23 ol4 kernel:  ? __wake_up_klogd.part.0+0x3c/0x60
Jun 03 22:25:23 ol4 kernel:  ? vprintk_emit+0x104/0x270
Jun 03 22:25:23 ol4 kernel:  ? wait_for_completion+0x86/0x150
Jun 03 22:25:23 ol4 kernel:  wait_for_completion+0xb0/0x150
Jun 03 22:25:23 ol4 kernel:  vhost_scsi_flush+0xc2/0xf0 [vhost_scsi]
Jun 03 22:25:23 ol4 kernel:  vhost_scsi_clear_endpoint+0x16f/0x240 [vhost_scsi]
Jun 03 22:25:23 ol4 kernel:  vhost_scsi_release+0x7d/0xf0 [vhost_scsi]
Jun 03 22:25:23 ol4 kernel:  __fput+0xa2/0x270
Jun 03 22:25:23 ol4 kernel:  task_work_run+0x56/0xa0
Jun 03 22:25:23 ol4 kernel:  do_exit+0x337/0xb40
Jun 03 22:25:23 ol4 kernel:  ? __remove_hrtimer+0x39/0x70
Jun 03 22:25:23 ol4 kernel:  do_group_exit+0x30/0x90
Jun 03 22:25:23 ol4 kernel:  get_signal+0x9cd/0x9f0
Jun 03 22:25:23 ol4 kernel:  ? kvm_arch_vcpu_put+0x12b/0x170 [kvm]
Jun 03 22:25:23 ol4 kernel:  ? vcpu_put+0x1e/0x50 [kvm]
Jun 03 22:25:23 ol4 kernel:  ? kvm_arch_vcpu_ioctl_run+0x193/0x4e0 [kvm]
Jun 03 22:25:23 ol4 kernel:  arch_do_signal_or_restart+0x2a/0x260
Jun 03 22:25:23 ol4 kernel:  exit_to_user_mode_prepare+0xdd/0x120
Jun 03 22:25:23 ol4 kernel:  syscall_exit_to_user_mode+0x1d/0x40
Jun 03 22:25:23 ol4 kernel:  do_syscall_64+0x48/0x90
Jun 03 22:25:23 ol4 kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc
Jun 03 22:25:23 ol4 kernel: RIP: 0033:0x7f2d004df50b


The problem is that as part of the flush the drivers/vhost/scsi.c code
will wait for outstanding commands, because we can't free the device and
it's resources before the commands complete or we will hit the accessing
freed memory bug.

We got hung because the patch had us now do:

vhost_dev_flush() -> vhost_task_flush() 

and that saw VHOST_TASK_FLAGS_STOP was set and the exited completion has
completed. However, the scsi code is still waiting on commands in vhost_scsi_flush.
The cmds wanted to use the vhost_task task to complete and couldn't since the task
has exited.

To handle those types of issues above, it's a lot more code. We would add
some rcu in vhost_work_queue to handle the worker being freed from under us.
Then add a callback similar to what I did on one of the past patchsets that
stops the drivers. Then modify scsi, so in the callback it also sets some
bits so the completion paths just do a fast failing that doesn't try to
queue the completion to the vhost_task.

If we want to go that route, I can get it done in more like a 6.6 time frame.

