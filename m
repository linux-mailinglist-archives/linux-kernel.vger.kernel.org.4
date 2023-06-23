Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66373BE88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFWShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFWShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:37:42 -0400
X-Greylist: delayed 1074 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 11:37:07 PDT
Received: from mx0a-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2872954;
        Fri, 23 Jun 2023 11:37:06 -0700 (PDT)
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N8IXAo009767;
        Fri, 23 Jun 2023 13:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=Gd7HDZlbX6/DJyjK7WKVElCMRj1HSxaZ7XAAZ/FhIcA=;
 b=YRDb6+alcmvrdl+pvgI7pBwZUJ/fyIE0Pzinh6vAf9Alv63yyROqkYBt2vFIkdMR+XRA
 qo3Q6J07xUSgxOcwj323C8OolONS3on107l/+ll+X4jCBCIaTTRNGpnJzCPkSICl6MH4
 RHmxxlRoY3+K2nkQXkwa4twEZ1S+9nSeoKxrJGx5SKG/3TvrNj3soC9Jt75F6ZoBhff/
 rFA8QZLli7r7oNMhA3DG/EWazRfreIeJFeL6HEwZOKtu5OrwZJX+3wXWUYVM87lo8yiy
 KU9iaIxflgTM2oyivF7/yUthW1eBtmKrXT2MN1CTeYo6nN9qUCY4tm2sT3Pxk6GGXF8f LA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3r98wdab8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 13:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6aHm2nCsIEvT4gQ+HDI8K7yy85FZpoco+MUOyv9l55B8rKI7mlPiFuiTgJ+oagdaMnPpki+xGcMOn07B3xfQ19XDFA2/CCuPsmeOIJKbGb4gLbLgc63XwSX0km9Z9GgoplvOXLuF2XWWmDsQcwInKaqGMHSyB9Pm6HdXSwLaJgsfDCg7dn2ax3/F2+wqZpOkPIpcDatCGNeFI9hpiZE4pQ6hTlKnUdZmDBrm300Cceq81L/cYHonXbaMnDvbKl591OPrfkEmkqwEDjwAUNcVQOumiiCZPSAUU2gjJjeFrS5Scokk3Tqd2/HbD/k3g5uLkU2sILHodm1JvcTJ72huA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd7HDZlbX6/DJyjK7WKVElCMRj1HSxaZ7XAAZ/FhIcA=;
 b=luH7vv9ZJdT8Ls51usW9oAdSp6LFe4ytC5vX8333+Y0BKOzfJY4qdnWzU2FR+ZNvtib/QaA2gUkfAgsiUCdckCsSHdBbiwAsuBqRsfs0fMuBwkS6rtnYlgydWlCuziKPlxZAuqbwTml/KK4SzirwRRZT+Hj83ByX9678uwIcuMMxB31qBmJoD0dt458j0Wdqb8kJg4Ej9mI18n4nVBmZWl3Nw2QE6sRJEdl1uLwywsUPvYsJFchziIChxYI+6idthXaa8XFeakVh2lNr/fR9gUt7dzfYFAHg5lO61jwO58HT8wKs/E+AY918Fl6Qc9rIUCHoZAC1jsQ0riWbjoiHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd7HDZlbX6/DJyjK7WKVElCMRj1HSxaZ7XAAZ/FhIcA=;
 b=cxAK6L7cdcxHTLYPxUDKVypnTEQfhGVqBWHJoZ9YTRLGhZEvDs4rWwn7cxZCVWxtLDnc0KGTWbSqlbmvkxhnQdl13gCnsxDlQVfSjtB4CFStGrcKMWeM0Xn51IZSN64++Lx64HpeBsRPA8xcvIjtA4kb/e/dICzIWebPts8RBsM=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by CO6PR04MB7492.namprd04.prod.outlook.com (2603:10b6:303:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 18:18:52 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::4e3a:2e07:9d5f:2ca]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::4e3a:2e07:9d5f:2ca%2]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 18:18:52 +0000
Message-ID: <30fb1e3e-c130-b738-3a09-da525ae97de1@ni.com>
Date:   Fri, 23 Jun 2023 13:18:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 tty-next 2/2] serial: 8250: add driver for NI UARTs
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20230505213850.829639-1-brenda.streiff@ni.com>
 <20230505213850.829639-3-brenda.streiff@ni.com>
 <4585cc23-aa14-7916-11e5-3d3de3153d80@linux.intel.com>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <4585cc23-aa14-7916-11e5-3d3de3153d80@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::30) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|CO6PR04MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 408ebd07-4b53-4bec-4040-08db74164c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/iawYQsKHFFLKrU/KQqJMmaFY7VoivnWeD6DRDWQunqnYjH9+Dv5W1fWJmeleNYtrGuE9LWIZ5yFmfghfevjSk4nWRv9P2BFJ/B5SGGKEXdZb6SEOC3YspcEE6dg3+G93/cDT2peyiwjrF5Cn/2IO1T4ttxtzj+7JUGipkf7ZQP26+QZELSBAd7Ewmz7TY4puiI/Q6x7z3iegJaqSnUiiOHkDkLezqWgZmIwe5OpF+PpqXb3dCQVhvnxd5O67xD4u/kxNZURTIbAC/4aoR37MfiiVAUaagqyvmccbOb+/gC2b1DRgrw1SRiqERaL0QujFwr2DzFmf69jGKTRw3OPRGzJ86gFbRgI0k25DOid5rIcQmyP4WQoqP9ZGpTx2pnq+1l8aeeR3sIDqT9t05ZcLvJ7BwVtiHUZ9ttxkloUhpzgljIPL9b1ocjRec7OYr+ysAXS6vypnMrn8vG6Zy5JqNes1XbYwrVo+HkJ88VIRJ36xJQxwOSTIs50PbgOskUjvT8ehN7paQwkEX5Wy6wAla3BDup0ee7jahBhsHbZPUtpM2Yz53o6GvR7Q7oLHLV2eaav5q91NQA6F1EbNPrhrkkpvb0jSeW5oZVlSDFWWzhgCdOSgx3xzDTJskDra1a5PwLflwiyEOsF8W4ds8Dq7xha6ecsCJfW/n8d5LY8ZwpmR3A4rxlW3tR421Tl7SN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(6506007)(44832011)(53546011)(5660300002)(31696002)(86362001)(31686004)(66574015)(2616005)(316002)(186003)(54906003)(2906002)(6512007)(26005)(478600001)(6916009)(4326008)(6666004)(66946007)(66556008)(66476007)(41300700001)(8936002)(6486002)(8676002)(966005)(36756003)(66899021)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJpa08wd1dMM0h4c3BBTVlyWWhNSVZsaHRYcXdOYW9sZkJOeXFhVTVsK2lJ?=
 =?utf-8?B?dDhqYkdHTnlhY0hNaWkyalA1cWhMbnZrRWxQUExCcDRlaG1jQ0VkajUyTTFq?=
 =?utf-8?B?TStzZTVYMjh5cFBwUXFNbngvZW14VlM3Rk9raGhZTU9DZVo4VmVyZXFaWW1O?=
 =?utf-8?B?MEJOd2tncVp6ZEhUdm5CUzJKemEwcXRnU3Nsd2gyb0pyWkJVbytGbTU3TitK?=
 =?utf-8?B?SGw2blFGV3g3SExrS2FSeTQ1aWxRL1hsZ2VIVWI4Smt6TjJ4RCsvaTV5ODNi?=
 =?utf-8?B?TVl5d0JLRGFqNzFUWjc0WXpFSUFmVlI2QWNVTGR4K0E0SUFISVdMa3ZYUk16?=
 =?utf-8?B?QWtTbGorMzA2TVkyT2JrZktQZEgxTmp2QmI2R2UwTGQ2QnFRQllrUlp3UXRr?=
 =?utf-8?B?aVgvUTFkb25DNUNsWGpEdjc2bnhuQ2UrY2lxb0QxdWJDTnorMzJiLzBlZzJH?=
 =?utf-8?B?UmFFNVNEYnFOaDJIMkpTZWxEVmN5QkJ4VEtmTXAvR1d1UGptOGRjV1dNVDhU?=
 =?utf-8?B?eGlVNGVXeCs1QWU2TmJPMDVGSXdaM0h5UG9Vc0tUQ0dGZnI2N2hHbGl5TTJY?=
 =?utf-8?B?WXRRWnd2SzhZRFRvYWRraXNVVjl1RHpaSG9vOXlScmhMcnJqaHkrVlJsdGF1?=
 =?utf-8?B?SU1iQVMzZXByL1pYaUt5Q3A0akovRTBJcXVNMlhZZk5MeEQrTCtYNGo5RzdW?=
 =?utf-8?B?cVZaaDcwZzhaQlExU1pETTFhS2NrdmpYbUxyOWZTWVI3Zy9PdW5WZXVtalJC?=
 =?utf-8?B?dysvOUZIVWd2RXhpR1NlVS9lMkxYNmhpbC93aDhzZytHbExkSkwvbk5MQ3Zm?=
 =?utf-8?B?OGgvclFBeUJQWGdMcmJtamRuSDBtSEdrSVdVeU9MNEFyNHN1Y3ZlQlE1WjFZ?=
 =?utf-8?B?Q3ljY3JFNkd4Y2huVzI3VnBlL1h5d29Kc0R6RGhVQmNVSHE5VjVNZTFkQUlQ?=
 =?utf-8?B?bm5KSUlYSzZtSkpzenZpcXYvL2c2OC9ONXljeUROQkx4YXZNWjNUUDNQRnhQ?=
 =?utf-8?B?SlNDRGxhOXlEREd3UEtta0lhNlFpS0c0VDVVbzI2dlBLa0grazRoZ01zNi8r?=
 =?utf-8?B?cHVIR0FHUW5jQTZzSXVHR0tYTGVrbkdvRW1sVW5vMGlsYm1VdjZXOGZJQTNN?=
 =?utf-8?B?RjhhY2M4d0IyWUJNK1JVZWNJTVVJbXB2Qm5PVU5rMXhKQ2gxZlAxZWM2WE9m?=
 =?utf-8?B?Q2t1ZlRCQnMvOEY5VWZZYW9vSENGQjlVUUpuUW42K3JhdTVYQmVFZEZqZGNw?=
 =?utf-8?B?LzZ6Z200RVdRNEw5NXA4a0sxYXF6SFFlWXE5a2loY0pGVU5Vcy9xS3VlK0kr?=
 =?utf-8?B?djQzTVFXVkNDMUt3VEtUN2U2S0pJUUQrcmErdEhYUFZnVkdlY2JqVTRQMFU5?=
 =?utf-8?B?VnRzV1EveWxJYVY0SjUwNEg3THRmaVc4bGFnbGF6WUVMVnl5MjdqQjI5c3Bl?=
 =?utf-8?B?STA4eE4zU3ZTNGNCa0hreEpaRUxuSVI2OEU2cTZxMW93cWlZNGk5aVdjbk9p?=
 =?utf-8?B?UStDTTNoWFZGTnpISmhHNHdQZ3hNbGtyYTh4VVVpV3dZc05yUFY3U2luVzF3?=
 =?utf-8?B?S2kvL3dTWG4weGhkZGtrR0c1L0p3MWlMMzlaaHFNVFl2WTlmWFFSUWozUmN3?=
 =?utf-8?B?bXJWK2VIR3c4UCtCQ1g3dWtZT0JNRVpYVlRVZ3RobXgxYlpDdWVzOXlCdHFm?=
 =?utf-8?B?VlpXT1dzM3VxVG9YYUpheWxpT2paR2N5dmpicm9zTkgweDJFTEtzV01sa0x1?=
 =?utf-8?B?OHg2VlNhY2plbkZRMGZaVmtZL2REeUdKTEpGemtaVk90Q3RBTmMyRXU1bFZQ?=
 =?utf-8?B?Um9wU0Roa0hWUkRTYjI5ek5veTVxSlpncmZqRjQ1UDd2WXZscHg3bmdoNk1z?=
 =?utf-8?B?SVZjMldoSVQ5TmZ6aGQ4YXVpcjFKMGNWS1liZ1RCT2ZnOTAwRXNka3pCTzdB?=
 =?utf-8?B?S0NzcFpTVjdkNlVLazhVODdPb0JSMUpzTFNBNzlwRmlLY1h3RDNCbWtHVito?=
 =?utf-8?B?QURySVF5d3N5Ykx0bTlOMXhDOURBVkk1TXRSczlGWkM4M0tGTVNaWTRYaHRM?=
 =?utf-8?B?YUhSYnFLSjFOLzg0ZlFhZUxteFAwYzBtcnpFM0srUUZQTnUwb3ZHbTcwWFBG?=
 =?utf-8?B?Y3NHWXJUandEaXZsTzBhdlBDQWM1TmVmT1JMZUJoZGFZZVBlcHBQdVNHZ1lz?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408ebd07-4b53-4bec-4040-08db74164c3a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:18:52.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erteAXWWGuoRdNG0wLxi5kXxcqyMUkuUBEtsKiOQLw9bsYN0w4QExWyd18MhzCtxy9j5ti+I27GXqSd3XA4YNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7492
X-Proofpoint-ORIG-GUID: sEWu-TwM41a7cnRSIksqXoYP-IMhSwJk
X-Proofpoint-GUID: sEWu-TwM41a7cnRSIksqXoYP-IMhSwJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 clxscore=1011
 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230163
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the delay in response. I have your other requested
changes in a pending v5 patchset, but answering this question took
some digging (and I got bounced between projects in the intervening
time)

On 5/8/23 03:01, Ilpo Järvinen wrote:
> On Fri, 5 May 2023, Brenda Streiff wrote:

>> +static const struct serial_rs485 ni16550_rs485_supported = {
>> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
>> +	/*
>> +	 * delay_rts_* and RX_DURING_TX are not supported.
>> +	 *
>> +	 * RTS_{ON,AFTER}_SEND are supported, but ignored; the transceiver
>> +	 * is connected in only one way and we don't need userspace to tell
>> +	 * us, but want to retain compatibility with applications that do.
> 
> This is a bit odd statement. If application wants to specify those flags,
> they will be ignored (cleared) by serial core without triggering an error
> even when driver does not claim to support them.
> 
> Or are you saying some application sets these flags and fails if it
> doesn't get the same flags back? 

Yes, this is the case.

There's an unfortunate amount of historical baggage on our side here.

The hardware supports four modes:
   Wire Mode              | Tx enabled?        | Rx enabled?
   -----------------------|--------------------|------------------------
   NI16650_PCR_RS422      | Always             | Always
   NI16650_PCR_ECHO_RS485 | If DTR asserted    | Always
   NI16650_PCR_DTR_RS485  | If DTR asserted    | Disabled when TX enabled
   NI16650_PCR_AUTO_RS485 | If data in TX FIFO | Disabled when TX enabled

These four hardware modes map directly to "wire mode" settings in higher
level NI software APIs, such as NI-VISA's VI_ATTR_ASRL_WIRE_MODE
property [1] on other operating systems, and our drivers for those OSes
just present those settings directly in their ABI. Linux already had
support for RS485, but when the driver was first authored for Linux [2]
(and then kept out-of-tree for a decade), it was done so with an
(erroneous) understanding of the RS485 flags:

   Wire Mode                struct serial_rs485::flags
   -----------------------  --------------------
   NI16650_PCR_RS422:       0
   NI16650_PCR_ECHO_RS485:  SER_RS485_ENABLED|SER_RS485_RX_DURING_TX
   NI16650_PCR_DTR_RS485:   SER_RS485_ENABLED
   NI16650_PCR_AUTO_RS485:  SER_RS485_ENABLED|SER_RS485_RTS_ON_SEND

The "RS485 serial_rs485 sanitization" patchset [3] ended up breaking us
and forced us to reevaluate it, because now some of those states were
invalid (a driver cannot now simultaneously support not having
RTS_ON_SEND at the same time as supporting having RTS_ON_SEND).

Ultimately we made the decision that we only care about the RS422 and
AUTO_RS485 modes, but now we have a slightly different problem, in that
there's a bunch of userspace middleware that is still coded to expect
all four modes; so if we remove support for the SER_RS485_RTS_ON_SEND
flag, even though we don't need it, we end up with:
- middleware sets SER_RS485_ENABLED|SER_RS485_RTS_ON_SEND
- kernel coerces this into SER_RS485_ENABLED
- middleware reads back the value, sees the flags are different, and
   assumes that the mode isn't properly supported and errors.

So we need to "support" SER_RS485_RTS_ON_SEND, even though we don't
require the presence or absence of the flag to direct any hardware
configuration change, in order to avoid this coercion happening.

Ideally we would have a userspace more tolerant of the kernel now
coercing flags differently than it used to, but unfortunately we're
stuck dealing with it for a while.

If there's a better way you'd prefer this be handled, let me know.
We're trying to walk the line between "the driver needs to present
the ABI correctly to userspace" and "our userspace relied on it having
been incorrectly implemented in the past".

[1] https://www.ni.com/docs/en-US/bundle/ni-visa/page/ni-visa/vi_attr_asrl_wire_mode.html
[2] https://github.com/ni/linux/blob/nilrt_pub/14.0/3.10/drivers/tty/serial/8250/8250_ni16550.c#L96
[3] https://lore.kernel.org/all/20220606100433.13793-1-ilpo.jarvinen@linux.intel.com/
