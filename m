Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38426E6C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDRSud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjDRSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:50:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AB170B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:50:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IExLrT023722;
        Tue, 18 Apr 2023 18:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=w41QWvKlRXSeJ1c2741ngBApovqpBoBmpN3GTJ4e6eI=;
 b=mcW3DNOFZ/8qFDk5qhU5OR3NcjnCSkA8N1bSUUhqsSRBdS/qPbzrAul6yptPR6287O+q
 xw23r4WP363AWnSMy3458T/kS3H06CvQEaw6LGi8kctMfKroZQuYtVhcYrcdLzDAynG3
 PySE1znWZQQI81YkhyKlhPARkk9P3+mdxmBY3dlXqKl1OL6C7LL760dQSkIQqihYtsnN
 LxvEEgoPOu7pFiZiGg1hIie+NpefL71bawHnmB7BPMyyTPqD2O/2alyolukUTwhsX2Ow
 sJ4KuuvWEFpgCChdJBJJV4i9DeTE+dDOBgPah1ytccX24BgSQQ/3pkuXi3hRygY0v8DG rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjuc6jss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 18:50:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IIhsor011415;
        Tue, 18 Apr 2023 18:50:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc5nq54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 18:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMy4xaogtiY3IkklU6dJRVy5FCKKNJbE/iTso9CxCQgTnG0YvHjKYgGNG9Gr+0/dk4hV1Y/fssql0LUES5c6QB7Gl+tNoQPcRbzDfWCDqZimzCbwfF1UxCmN7kShPvWgP7vUwatni2H8ns8lmYYt9itsWCfXxS/ulYHpkmM77uNVNI0zcsGZrDZ0XSvOMqnJ2P5rGnjgVkWDY6fPSPFcc74lVgpg/7+xqwl9+ke71tgzZnngdOzzmN50+68TEuQ8SwS7LUSZJqYqiAOP8sVbWpyMfq7HhJvF8ySimhyONjqCltF+mviERo0YvBIi2mrLWveCpp5AxBzSV3AJAUC/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w41QWvKlRXSeJ1c2741ngBApovqpBoBmpN3GTJ4e6eI=;
 b=h5QbuU9xBWngqQydnjndtm6bfQoob+n0aV079YDT1+MIJ4ZyfMn7lcfkGOeT0oc0p8CHo3RRAgAGI+Z+Q6tNkeoAFS0GmT9zp2mJ/90plVbBVpjb0k9/DWaguR5UIkiodYG/TriwCNBJF3kGN1w9A8zgmilv2H0VGA9lkkA/BnkixB9qZn6nQNP3ltDablV/J6HmYsGsXljBqB+iJoHsklAz+b/LtIarrbElfZZXom8WrqVdQ/5j7V3rqyBJUyMrB4ktiFHWABhcWzBAVxBFEQaAnLSEILsgLwgzWNwnk4NEdnic1Ct2AWEz/OGG2x/fmNDynylxXbpkrFj/BxAmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w41QWvKlRXSeJ1c2741ngBApovqpBoBmpN3GTJ4e6eI=;
 b=IH5aXGL8mQ2BAsYYWK5PxX/7fIx6IiQTtjquiZ4TTVF9RuzTpcZFX7qh8fa5bB3b4qHWV5l3XmkT/5Dtv8aNyEjruXp/VybvgsQVm+aLc8bz19ZZS4wQicgI6JHWeZcZOQ9Hc9xrC8/6j3TnzqKgnof6aYsOv+ZYB2mLuUroww0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6685.namprd10.prod.outlook.com (2603:10b6:208:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 18:50:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 18:50:11 +0000
Message-ID: <8404e7ef-d929-bd39-a10d-f4053cc4bd3e@oracle.com>
Date:   Tue, 18 Apr 2023 19:50:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com>
 <6b14b2a0-cf1c-fbfb-5028-d7a6974ef39f@oracle.com>
 <CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0382.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: db3968fc-4555-418f-aa45-08db403dbce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTgXGIB1Q8TGL+eKOCOkAreiyic5a7/rIXzqzmD9Mo4Tz/OIBEw8F9bWfOfcZPwMr3emB4PESLNkCRm6hv0eOysL2dMCmlXOpOFpY8xuwxkbLQS7OAjchn6eDY4TDIQiV91Zz8ggT13Z3s2lcy3v062OTYwF0SyBsa0zD0xjc5CBM7scC2XqNNWMn2irqCLthMcSjM4UiQpVuFRE9KTZSZ+fV6ACLdLnpL+DnpKzjltFYQIFeV4Tvz2N0jM+4aT3vCbkDFwiHz58v94tRzsU2Ya1QrRQWoTWG0xAE9gobKH+kJSEwt43uudRttNr0QceLARxJr+sK/G8UUYDwdRX4trrnFbDtTGr7cfztocnoFtiQPNnZm7z+Gy11Yc7pS5mbpowvr4TQIrDp5Pd3f1RDaZ905/qcdwJ1of+axgPcpfcSlCHHm5P04rPbCQwjdUQdjwPc1XE/jlqLpG4P51tqQtbjnxLeGgJQacSotAwrIo4gT2wSLXUulcKujquUHMk2z/LlCUsG9AiMBvbAz2kO0wysuOFkYOl7S9Xk9NT1NLRCfhVw0rmrP8d9Bn/dUTtbhFpq9tbV8WGl8nL7CzcsOi5NTOP0aE9Q0TYAOLQ8I4rg/SVPfLkusuEtFzHNFE3IytRnVR577VEJnNEzKoZFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(26005)(186003)(6512007)(53546011)(41300700001)(6506007)(54906003)(86362001)(83380400001)(2616005)(4326008)(6916009)(31696002)(316002)(66946007)(66476007)(66556008)(36916002)(2906002)(8676002)(8936002)(6486002)(6666004)(31686004)(38100700002)(36756003)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRITThIMFBJMG1pcFkrYjlWMWdWMG9NTVQraEhkL29ic2g1Q1VmVUQ1NmE1?=
 =?utf-8?B?Z3ptaVRjSVkvcmh6NjBYdHU4K096R0k3TFoyamlUa2gwckNmRlhMUGVNdDFt?=
 =?utf-8?B?WkFJZ3FUQ0gvNlhvT3FCRCt5aG5zRmYrS29ZMWtvcDQzRFpPaFJsYUlDRWJW?=
 =?utf-8?B?NTV4c3d1ZSttOGtRZFUyYlZzZ1lqd2NRcEN6ekpsL3lsTEg0VDIvNS81Nksz?=
 =?utf-8?B?WjZpeUtPMFVTcHNOOExwUVYyUXBJVU1TTVlHZ3lweTFtOWRLSk9JQkl1OWg2?=
 =?utf-8?B?THRmd25jR0lCTEhmN0U0U2hoKzQ5TnJoZEtTeFhqcGs1TU9DQTNqUWZGS1lY?=
 =?utf-8?B?TWtWZ29aWVBuZlQveXE3dnF3OHl6bzFZeDVLRGZoaDU2SW9Zb3dxR05Yd1pp?=
 =?utf-8?B?aThtRnZieDZIazhLWFRlbVkrV2lzWnJ0bHZYeEY2MElqM09lQkgrbnpxMmlW?=
 =?utf-8?B?TWVlSjA2QmdYVWNzTkpScGZaRHZOdkU4RDAxQXdMd2VnR01KQlQzdGx1YjlJ?=
 =?utf-8?B?Sms5aU14WER1b2lGYktpa0pqNm5zS2JwNGUybTlVN3VsZmwvOWd0Z1FXWDh6?=
 =?utf-8?B?TGRKNkU1MVVlSHJKTllLRVdLT0RFekw5cDVxTjJvUU1wb2Q0YlZPVXFMYkxB?=
 =?utf-8?B?Z0lqWHpsWWJoMzNGWGs1VmRPZ0xWa2NKZ2J2Vi9wRWtLNXJRM0ZPVUY2MDIv?=
 =?utf-8?B?Y1d6ekM3VnNTRnlza0Y0K0h5aHdWSEdxanBFdlRQRXBYZXE4NmJrK1U1bGR0?=
 =?utf-8?B?WGoxRDVZdmovdmtkWlNQcDArNFRhYUJiR3hWY1RGUGJ0VXNYVjVNOVdpQmNF?=
 =?utf-8?B?T3Y4STdiN0FzK2Rja2dXK0QyUE4valVNOXdJTSt1ZVl1NDFBMGhLdmVmUFo5?=
 =?utf-8?B?Rm9qalhuTURpUHhxWUMvOHpsbm9UK0FOcVpIeFN5djRJVGJFdDNBTHRXNE1v?=
 =?utf-8?B?SXk2UytuT3cvUWJiczEwdGdUZXczc0daK05mR1c4V1JNbCtMbUJpelBPYVIz?=
 =?utf-8?B?WUFQR1dURVlGRzd5aURYV0Mwcks5YStLTEswaEdnN2NKYTN6OTZPbEpYcy9Z?=
 =?utf-8?B?NTk2Z2ZHb2I2ZHhzVHNPcVpKZGJXYmEycEZ2NHd0ZUhYK2hNTkRGRlJ2c0dv?=
 =?utf-8?B?MnRUUVoyWSsraW5LWitWWnQyR204b0RVeVV2QmphVDl1TEQyUVdQbDF1NjR3?=
 =?utf-8?B?SUFLQXFkajJ0NUZMaE1mZUhDUWp1N0QrZzB6U28wS211R1NXUElMRTFGdWVH?=
 =?utf-8?B?WnArUGN3U0NiYThITi82aWNJSnVGY1lnRWxBbzJ4N2N4bWdVVGt3MGg5c1JJ?=
 =?utf-8?B?aWJzNVUvM2xOL2dBK0QrRDd4b0ZEL3c2elBXS2FQQ0pVWmM5TkllYi9ra3Vy?=
 =?utf-8?B?SmpJRXFxZ2N1aGxqNEdDYjcwZ041N3AzcHAzWXRWTUxMbk9jak9PNFc3N3li?=
 =?utf-8?B?N21QNW84UnVkYW54T2tKbXUzcWdKcGVNRGwwM2s5ZlVSamVrZFl0d1F0aThY?=
 =?utf-8?B?d2JNVjVkWFhaV1ZySUZVVC9TWXE2MG9QWmF5d3IwcUJNdTZabDJVbHVYbE16?=
 =?utf-8?B?bGptOE00UXIyMHFlV3A4cEZZTUZBdXdhcG5lZFN4N1F3dnVGQUd6czB1NTRv?=
 =?utf-8?B?eS80aHllY1BpZ0FTbFl5V3RMVUNhNnpBS1NvYkJnZmpOUEVva05uQ2ZaTGVp?=
 =?utf-8?B?YTdWcU9CcWlKRXRSaDM0K2JBd0U3NEhoSzR1MjlSa1BUNTNMMmhLYVlXM2Jm?=
 =?utf-8?B?OEs0KzRhSlpRd0pEQTl0RG4xWExLRTNEWWdrTlN4UTZybVc1MXZwbW9SVWRO?=
 =?utf-8?B?Nml0SUkwaTRhTk9OeGlLMi8vOWRNOE50SWRjUHlMOGY0eEJrYWlXSDNZd2sy?=
 =?utf-8?B?Sml6a3NCRmJ4bml0eldEMXVwdUNuUldpOHg2d0hQUUttWTJHVFUrR05iL0gz?=
 =?utf-8?B?YWlhb0Q1R2F0U3h4b1c2N3BjaHVBMUVCbkRPYjVGU3EydkdNcGQyZ01UV2dh?=
 =?utf-8?B?UEdreWxyNmlDNlZlTDBOT3VPQzQwRVhkZUE0OXJiVW9JTXBLam4waU5rWUVq?=
 =?utf-8?B?WDZwQ1NHb0tqd0hVNUwxVHBZZ1Q4NU9XcW9JTjdudEUzcWYzdFIvNmJiNHJR?=
 =?utf-8?Q?dMK/pIOuBbyXvMT+yK+xAmpXC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aW91TmhmdkJrNzljZ2pxMy9hNEtzcm9LTmJ3d1BnUDlPeW5rUmJBVHNkSXZ1?=
 =?utf-8?B?YkY2YXBCZmlrT09TaUZ0TEdJTHBTTEtYdVh2Mlk3ZXE3OUZYZk1OdWpLUlVl?=
 =?utf-8?B?bkxhSFVGYmtEMmp2U3VIdDU2QlBEY2MvME1DNEpqWUhwNE9EbVczQW5mMWZ4?=
 =?utf-8?B?M2NSd3hUcjRWUjBic3cwdmVNR2FxYWoyMTlGajJXazhDUmRuVWhleGxlRU5v?=
 =?utf-8?B?QVFWSDFWaU5wdVBocWVONWtjMVZRSW1PQXI1STRGa2VTdnV6Y2xOQ25yV2xH?=
 =?utf-8?B?LzBYZk1aNXlGb0RtdGduVTdBKzVzdFFESFNyNTc0K2hQTkw3ZXBrTHlSaFBB?=
 =?utf-8?B?OWlJaWE5ejQwODlOTm14eWltS1hsK1pWYnoxZkw5TDlHWFBEejRwUjBBZVYw?=
 =?utf-8?B?RXcvZHFLekVBcWVrT2ErY2NNeXg5N3EwOHFwaXZKd09HcEV5MXJkUUl3cHRa?=
 =?utf-8?B?YjZBRnlvZ3J3Sm9sZmxvWnRzdmZkN1IzTVhHdSt4VDQ3NmRJZWhHRm9zUjYx?=
 =?utf-8?B?cFpzaFdtd1FQUXc3d2pseVMyYXM3SFlTK3VzeEtad21yZzBBZWdsY0NCMDRr?=
 =?utf-8?B?TmR0VDJudkFpb1k5elc3Zmt4Kzl5bDJvZkhoMmRIUE5SN3hYQXI2MVRTRWpl?=
 =?utf-8?B?c2xVV3g2QnhjbUZxM01HdzFsdWNYSzVqUk9GNGZZQ3lXNUlXZjRteWljS2xL?=
 =?utf-8?B?bnBGT2p5QkUzejNqTnUzNXh2bDVzQkV3Ry9lOWJoc2pwUEFVdnprMFNzREMz?=
 =?utf-8?B?dFdvWXp5V0hEVU5yay9hY2RTNkoxdGk4cGRXK3lrWmE0di83OWFqVTBJN2lL?=
 =?utf-8?B?cjE4Z3N6cm9zQ2V2WlZMeVUrUm5TN0JHRXBvZTBwbWJhcHowU3lRTTNONFNy?=
 =?utf-8?B?UEw3eEc3R1dLZDZQeUdLejhWd3FYdjcxdFhGWXZMYTdyZDI3ZG5Qem44bFg0?=
 =?utf-8?B?Q1VkSFY2WksvOTVsZGhBT3VWY0d2dDM1MkFWdnczaW1iVTdpd1E4WDg0WDFy?=
 =?utf-8?B?T2cwUU5xQkYzNU93S3FVSlozbU9WSXNUTGlaRmZwZGo4THB5TlBXdXc4YVJx?=
 =?utf-8?B?Yy92ZFVremNMZUlCK1BmSzd0NkhMMFFHeGhBTTBPMisvb0V4bEsrUGFTSUFN?=
 =?utf-8?B?bnhFSTZHbGYybFIrU00rSFJ0SWN5UXZNZkJVTk9EKzFnbDVnbnoyQ2xFT1lI?=
 =?utf-8?B?UTZwNk1rQnNuTHpsZWVoSmVoY092dUI3a2JtTWtFUzlPTHgxU2xhb1BYMEZ0?=
 =?utf-8?B?TFNiM0t4WGkzaGtvT0VFVGI0b2srNXQ0bEkrVEJnUVpsQVhwUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3968fc-4555-418f-aa45-08db403dbce3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 18:50:11.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpA5wDkn7DXoQoBeyT+GmM+Uo+3vnEq6gxv6dEirq8VTGrTGiubNDJ7B+tyuNsPsysYLmUeKDUrd7LIo/ssVeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180154
X-Proofpoint-GUID: zortFuBcc3GSrBmQ7fU8Hf6UgwxlQLJR
X-Proofpoint-ORIG-GUID: zortFuBcc3GSrBmQ7fU8Hf6UgwxlQLJR
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 18:36, Linus Torvalds wrote:
>> JFYI, Since you are using NVMe, you could also alternatively try
>> something like which I did for some SCSI storage controller drivers to
>> limit the request_queue max_sectors soft limit, like:
> That patch is not only whitespace-damaged, it's randomly missing one
> '+' character

My copy and paste error

> so it makes no sense even ignoring the whitespace
> problems._and_  it has a nonsensical cast to 'unsigned int' which
> makes that 'min()' possibly do crazy and invalid things (ie imagine
> dma_opt_mapping_size() returning 4GB).
> 
> You can't cast things to the smaller size just to get rid of a
> warning, for chrissake!

Yeah, sorry, I was just trying to show a very quick demo of how this can 
actually be done.

Indeed, I could have mentioned that it would actually have been easier 
to test by feeding a lower limit into /sys/block/<dev>/queue/max_sectors_kb

> 
> In fact, even without the cast, it seems entirely broken, since the
> fallback for dma_opt_mapping_size() is to return 0 (admittedly_that_
> case only happens with HAS_DMA=n).
> 
> Finally, doing this inside the
> 
>          if (ctrl->max_hw_sectors) {

I think that this would be set for PCI NVMe controllers, which we were 
interested in here. But, indeed, I could check for a better place to set 
this.

> 
> conditional seems entirely wrong, since any dma mapping limits would
> be entirely independent of any driver maximum hw size, and in fact
> *easier*  to hit if the block device itself doesn't have any max
> limits.
> 
> So please burn that patch in the darkest pits of hell and let's try to
> forget it ever existed. Ok?

Sure

> 
> Also, shouldn't any possible dma mapping size affect not
> 'max_sectors', but 'max_segment_size'? At least the docs imply that
> dma_opt_mapping_size() is about the max size of a_single_  mapping,
> not of the whole thing?

It's meant to apply to total mapping length and not a single segment, so 
then the doc would be misleading.

> 
> Anyway, if this is actually an issue, to the point that it's now being
> discussed for a_second_  block driver subsystem, then shouldn't the
> queue handling just do this all automatically, instead of adding
> random crap to random block driver architectures?

Other storage controllers may enjoy better performance with very large 
DMA mappings (whose total length exceed the IOVA caching limit), so it 
was too risky to apply a performance-related change of this nature 
across the board when that API was introduced.

So far it had only been a single controller where we were actually 
seeing the issue of alloc'ing IOVAs giving very (very) poor performance.

However, as far as I am aware, there was nothing special about that 
controller, apart from the fact that it was often creating requests 
whose length exceeded that IOVA caching limit, and it also filling the 
32b IOVA space quickly - that may be because the system had lots of CPUs.

Since there are now reports of poor performance in other storage 
controllers and also in networking adapters, I can only assume that 
people are testing more often with IOMMU-enabled systems with lots of 
CPUs. Having said that, I would still be cautious of applying that limit 
everywhere.

> 
> And no, I don't know this code, so maybe I'm entirely missing
> something, but that patch just raised my hackles enough that I had to
> say something.

Sure.

Thanks,
John
