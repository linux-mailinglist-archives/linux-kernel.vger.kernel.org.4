Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709CC7234F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjFFCDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjFFCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:03:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD621B4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:03:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355HiK1L017855;
        Tue, 6 Jun 2023 02:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=U8eTMPAOS4VcDAv1qZx+CqBfWks7/7JFIN86J+iPpVY=;
 b=WI98m3Cyy71wObafmZCAmot1KisDv5hdXXqu9b4cSMIhuK9g4LY2BxyYmBuZVbuNNDEg
 AP1cA5CXE+lV+i0qIf5m16BrjfZDpB6AaSIret3Ha7LFbmbzDPryM62Ychz0c157ee9G
 3bkV9vFzlM8UmegbfE8PAm17habbIhmXy8xVOQ9PCsfoWgqpvgxYQJfHfhL5fSr+Ct6/
 z6t1KtluPAldVpXqpDZDSczDVvEUvUHf6d/xl+p+P3jUxAwJcPRZ//lS4ag3HGORj+6U
 kw9+6VHTq6FK81sPfc3h+D4yUs6XAB6/Ts3+sOewtLYTAw2jjCqGFP9lJhlCpEY637tg qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2c4da5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 02:02:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3561eXvE020110;
        Tue, 6 Jun 2023 02:02:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tsx09ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 02:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUzKR8uHPNvpMH0EkYU2M6Bdgf+lNWHzeCiPxiBEVZuNLEtTsGrzGVYrAK3yLmNswDEhtEVUFcq2qyfjl7u8EUcK3ZkjQSbkSItrCuXMm8q+W3dQarJ2tMASUN7iTHorSaA7m/QbD5tswrlHgM5Uz6OMXztBJpTqYsa37AQVjPexQMVZ8efnUy7Osh+HZpm1est5qD7UnE4EYJ+EEEWXoVUR1797NeUdV7zk0ZfJhKFmyQ7d2r4PTWcmAkFzHiPH0cJ7Bh5YJrgUipXgZS6rNR+79rUSMbPVaZwzM2cyDiMljCnc9NvPffIvRgGcxLi4d9rnJJNOWTrwyavXlmOy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8eTMPAOS4VcDAv1qZx+CqBfWks7/7JFIN86J+iPpVY=;
 b=l963YBa6vrgRuUtC3lQm57MqJrUtY8mvM4ggDBezLeROZf+6jJswbJnM/w6FAuUi6z9X13bylv/Jf75l/Mo5zWfHdeVV1MbYOj7qGbjf2RwKY6EtL5LXJUVp4Fz9Ty3dRLD6DuUHAu+OcQbdyeB6QBggTf1UOUhpvXMbn6KZ3YhFm1dlkJXwF7YsnMsnWmCeDx3qENlvIiY3plQ7/1Y5NoOpd7++Zyi1JOuIarZfXNGRpAygtMnIN5sw2s9b83oSo00OtyWXwTRkMCaW7ib5XTWyGHGwmmQtosXLlBvPQvRN9jFKn5gpKd/BKOwKiY5mbpcLyyEibZTf3HQ439ZIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8eTMPAOS4VcDAv1qZx+CqBfWks7/7JFIN86J+iPpVY=;
 b=fvCfWN4/Cxwc5bHaJYLjPjQwS0JhGWRGbrhY/M8kc0SvwiI4a3LdA33NWzZzPOGFBWMHLKKGDsQyKLGw7X606x5J6fcQz0nGyAeTBP7Uh51jeubGGVdhyrpD9u0D8cJAOv+QUSVuW2irMftQomsBVs8sQqvJXSV1+nOAlKmCkY8=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 02:02:00 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f%2]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 02:01:59 +0000
Message-ID: <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
Date:   Mon, 5 Jun 2023 19:01:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC v3 07/21] mm: PKRAM: introduce super block
To:     Coiby Xu <coxu@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
 <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
Content-Language: en-US
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 466785d4-4a85-497c-1cbd-08db66320374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0JXVTN3HqxBxZBg+6EwZrEi+mZGzIVtAzF6GMpKVgXTbd/RoTAPjwycZmJCtF5qD2o7byUfshozFQrEKnNRfLpT/vvdKrk/3SmCAldoc62NRa9jQU6ToKi2ZDPCeG7ZgORu+4yn70xdaUHIYJVCvMwDR6M3LFyBBjU2Sqo+PNP8g0St7mhRGYZ604kUd80672CmwDbWRZKWnISYX5qa5Qbil7UDvrIQXUyDfN6pvFW6PtA/ebBQV2cdwXpbXb2DYba2DlgVtwQyO625kk7xsEs8Ywfomd4GSw978OTPWR54GqXpu0WWuu1Lxs+cqQotkTSPrx4IzW8pPE6zV6v15tKFl3JFLUs4zw9NK9XITQNvYoAbVvvFHj/bPKAfQvOMsH1JxBZbTqll2NjnTnVoh7sZhyaIJS7YaQP0j0q06yEAsEaknG/BezQhCjKVZHqW8fQNZ3KeE+gqapv3kiMBL+QakEPoVbunrxR8VYh8cNbRsCWD1lj0Qi0r3FvB9Bvo0Ond2bIoRJtJpBBFLyJstBTda/qz5Yfctbuecs21I8nc8WDn0eOcc9mgAA1aIKPznvDRq9FDdDWXRgVi8uzp3HGuiTPEaQ/D7S87OlYF3fQP+HDJ3JszooqvmxXIR02E3ZjM3KjOFIWXxHiZeOi0wE25RRz53ibkuPIPjgdBqJazFLaMS3wkdmjgCIGhfY2K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(6506007)(31686004)(53546011)(6512007)(26005)(186003)(2616005)(966005)(7416002)(83380400001)(6486002)(6666004)(36756003)(2906002)(8676002)(8936002)(44832011)(478600001)(38100700002)(6916009)(5660300002)(31696002)(19273905006)(86362001)(66476007)(66556008)(4326008)(316002)(41300700001)(66946007)(45980500001)(43740500002)(563064011)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tvUHRKM3RVOWxiTnRqZ2RNVzFsY2pHVDJvOHF5WUxBNk5TTmw2d0RESlhr?=
 =?utf-8?B?S01OYlJnWU9KNlBhR21scGVzWVZSeVAzWnliUHJMSFdic0p6R2tkTVJsU1l5?=
 =?utf-8?B?QnVqc2M1ODgwZTk0eDJIOXpubzBkNGdwVjVXbU02OWZYbWZLWGN2SkRKc2Zx?=
 =?utf-8?B?WkpWdTNqZTJFSlZUSVVaS1JUZlMrU2tlVUR0NXV6OW5ZTEgvb3RuQXF4SXI5?=
 =?utf-8?B?WnVaOEVOczREL0pxMlZaTzNUQU12Q2V3L1NBeDBtUjduRFVqbEFBVUx2SG0y?=
 =?utf-8?B?WE03eWVsREJObXJ3d0lmbzF6OFFVenRFUUVnait1SzBvMGRNZmJxMlhjNnB6?=
 =?utf-8?B?b0k4TFJrRWVCNXZpOHBJcmFmNEM4UWxDNlRnS2dtYVpuSE9xMkJUUllwVk5z?=
 =?utf-8?B?aFM0ZFZvbW4vTngzRHFqUTdqTWFpYnpLWUZPTDl4a01PMldjeDlweDFGWmtM?=
 =?utf-8?B?ODZyTUdIc3NtbGhMYm1EaEdiQWZ3OVRRa3BNc1AxcnJ3bE9EOFZ2aDJibXB4?=
 =?utf-8?B?U092UkZrbjNrRnR6RUZSSGxOTGdHMnJUQ0U0NHpNYmE5SHM3VTFSZDk4OWE2?=
 =?utf-8?B?V0FkR0EwR3J5YTNiUXpYSnBsZTdvSDVYbGZoMWZrbEVmMi9hcTNLUStPVXFE?=
 =?utf-8?B?U3NVcFM5Z2RtWlBockNKTmF4bEdLelcyQUQrRGljTE1Lbjh0VWYrWmNsVVMx?=
 =?utf-8?B?UFplZFlSdjlrb0JXbTFFUFdqY0YrdnpSRmtmV05adC9Wc3pmdW5xd0ZpM1Ro?=
 =?utf-8?B?TzRiQmVKcjV6dHZSQmE1Y1BjRFEwNVBVQlluZWJNdmI1S2dHMG9JTXpwVno2?=
 =?utf-8?B?Qk13aldEd2J2Wk5TRVNGMzM2czlldmEwbmdIU1VselZ4Q0lFL0V4cUIxRzBY?=
 =?utf-8?B?Rm5JY20rSjd4WXZJdHBLZkhVWGFLSUhpRVUyUDZ1ZVN2MXdCbUU2Yzc2R09o?=
 =?utf-8?B?YTNPNzlIbU1UU2NudEJmUmc2U1B1Y0huUHBhRUpTNU1RdjBxMGJXT1FyZUsx?=
 =?utf-8?B?NUFkZVpkU2gxbzFWUVQ5c3kwQXd3cjRsSGVDTEYwNThveC9XTk1VK1M0WTVZ?=
 =?utf-8?B?TkNTU1psTnZ5WE1ORWVFWXFFTUs5WkIzb2ZJcE51Sk9uNCtXdk1hOUx4dHVu?=
 =?utf-8?B?d2xieVk1VnhPRitoZUxpYTEvNlV6UkEvdk1vNUVueE11Q3VkcFYwMVhFZ1RC?=
 =?utf-8?B?MlFmMlZXdDUxTk0wNlRERitjMElkckg0aDRveHkyRStjaVJuejFEb0hLVW1G?=
 =?utf-8?B?TWVXYjlUTjUzWG5PdndZd3NncDJFd3FrVkpiM1RPSUpzSWxLVVd4R0Q4RWM4?=
 =?utf-8?B?K2w2MkxZaGhrMXJCRFQ3U0RSRnN1cEd3anRkNnBwOU80eDk4cHFtcDhZZEk4?=
 =?utf-8?B?TGxKTmdqL0VUZitLY1Zvd0Zhc2owaUt5TlBjZDlPRHcxNW1CUkhmMnJvYjRk?=
 =?utf-8?B?Uk0rcERpUzBYYTQ5ZjUwK29KN0FPUzlpYWFGZDFtcDFETlZPWGdZOTB1ajRa?=
 =?utf-8?B?RjJFVFVpTGN5NnZ0cEUrN3VpYnhxZ0sxVUQyYkFBMU9SSWNNWlZEcVZaUTN5?=
 =?utf-8?B?TnpkZGR0Q09QNTJhOUxmZWxBeUtPK256UFF2WmpOS0RlVkdwUUxYWDZuR1cv?=
 =?utf-8?B?SVNKZ1d3NVh6MGtBZllIbXRTY2J1N3N0MG1hV2VSSFRreDBESmRvbGo1MkVT?=
 =?utf-8?B?NVBpOEF3Y2IxTS9sYkRFYlo4eTVGb3hrYk13TGNnUEdwU1pYdm56bHR4Y0p2?=
 =?utf-8?B?bU04bjRTa3hkaXB6YkpIWHVqYkpkKzJwbW1BYWhqU1I1U0kycE5CWWxxZml0?=
 =?utf-8?B?dzhFQmc0Zk9CUmJoWHRGeVhCcytYSWQ0QVFrdjEvTmszcTZXYlkxaEZuTStL?=
 =?utf-8?B?NURub1J2UnI3QTVnMGNSWHJUSVJKbUE3YnRRWURkbktZcUZrcGJVa0JHTG85?=
 =?utf-8?B?OXZ0UktINGVoNG80bExDa2Zxck03cFprL1BOUlhBaGRoS21wZVFEMFg3L0tV?=
 =?utf-8?B?SEVIdVo1SFFQejFqcmRtS1RtYnVxVmRhR2ZHdHhRN1VvVFltdU4vR21aUW8y?=
 =?utf-8?B?dW5vQXhSUnBTRWl3ZE9hekZpZkpiRGpzTHdQSE9IKzNIbEh0Q2dCK3Fzc0tx?=
 =?utf-8?B?RWYwQ2RYSXQ2cS8zREZ0VFVVUWU3MDEvWXFLYW1teHRHdTlPZFMzaGFWNVFR?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?THpzeGVLWHpoWC95MllKc09BRFp3TEt5VWhITWxPcmxZU1RaOEg2U045Z044?=
 =?utf-8?B?VWlPT0lFdFk2Y1lyRlpsWVZKZVloMHhhQTM5czMwczgvaW1BMnd1TXNVWGJB?=
 =?utf-8?B?Ri9oQzJURU42RDZsNS9DZFNpWDhVcEI2dStHa0IzUHhKTi9QU3AySXVmQVN0?=
 =?utf-8?B?NzlZOEZoaWN1TzRRWFRLelRIVHdJL25vUy9VdHpaNXdqaHU0MFo3cGRsWWlU?=
 =?utf-8?B?VXk1YkRpZ1FTTFhoV1c1NmFyQmZqZWF5K1FtT3ZuT09CYlE0ZWszS2VSTnY2?=
 =?utf-8?B?ZDNzM256RFZNQTN5SUk1ZzB6dTlmSWMvaEhMS05TSVBBdG50NVNKcGlwUVlq?=
 =?utf-8?B?VGs4dy90Sm1XN0RTSGtSQWRCVkZuSDd4bnMwcEZQNEZhT2pLZ3dNNFcvSitQ?=
 =?utf-8?B?K3RBZStQYTYvc2l2N1lsN0hLM0tBMjJ1d1pvenRodzRJcC85Z3A5Rk14RFYv?=
 =?utf-8?B?Z3NzS05rM0xQWTU3Q1gwa3Q2aEduclE0bGZRS05LWGVFb0tqWDVJdWNtZ3F5?=
 =?utf-8?B?a0IrdnNoNGdDcjZBaVM3YUJKbTdDYnp0WTBjWDRHZUluUGlFOEpWcGpnQ1dP?=
 =?utf-8?B?aTJtZnloaWhMR2JGN3oyWlJiMmFYWFpZNmJvWGpnZFFTQUIxQnJQSjZVcTB6?=
 =?utf-8?B?ZG9IYXFNVWtWTmxKR0hQZnd3OUNLVUo3cmh0WWk2ZTZodCtZK1BuV0hnRFZ0?=
 =?utf-8?B?UmlaN1VuY0tSVzRyZ3duRUZ6aGM3aFkvdGRsRlJMczdrVFBiK2hMNW43MllR?=
 =?utf-8?B?MjRlSGF6ZGh3cUVrMGk1M3RYMUdTMzQzNXlwVVdsUWU4eks5WHpUUG9jK2Jj?=
 =?utf-8?B?ZURoT2ZrNkZ4dEpRMG1ZM0FMR2xRNXdpZCtNME9nL3NsMXN4QXVHOTdnK091?=
 =?utf-8?B?RjVVcFFDbXo2Y0hCRThaUXk4eFE2NlhHekZnWXlQRFlwVW4wS2h5N0s1SjJw?=
 =?utf-8?B?MThtMlFmSmN5cVhpRFZPbGxaa0xQcGJXdDdxckNRVE5nU2dzSTFITkxDNGk5?=
 =?utf-8?B?eHZkNGx3amlkNnVIUWxqTjlNVVBRMWJ5WnFqZlZtQU5tdllzd25NS0NNcGVI?=
 =?utf-8?B?VHpYdkhVSHJRK05wUmZiTXFNNVQrQ0xVdit4NGJJYUFDd216ZlBRMHM2L1dx?=
 =?utf-8?B?YnlnQVhjb1E1eUJvdFJWdUdHamZiSlR3dzBETTFyUDVWZGZTUE5OejErMjE4?=
 =?utf-8?B?Q21uRVBYd1AwUGRVY3hZcmxkWk1tN2hXSnVDMWFTTU1ua2U4SVRqZWl2bDBC?=
 =?utf-8?B?bXNIazF1WkwwZ2dUdnpGS3ZSMFRaSEpkc2FDU20wZ0ZCaUJZdVpxVTU1eDBD?=
 =?utf-8?B?d1RUVU9zYy9ONkRLckI2WmZEUGxJeHZLeFVBMUdLdjJieHhFQnJoL1dhalhR?=
 =?utf-8?B?ZXdEZVhldGdFaTZIRzkrUzdlWVhPbVVRdE9SenhxTDhSOHhza0FKdWdhRjNa?=
 =?utf-8?B?Y0hqMTRMS2NmQXYvRkE0Ri9IdUVkNWt2bk8xY3VXeFczTGZqcjdiUHphWTB3?=
 =?utf-8?B?ZmVHajkwUjJQelFBUzZ3Y3FxNGxCSFpNYkcxWWV4TnI2Tk94UFoxNGFVbW5K?=
 =?utf-8?B?UWZkR3JuOFBobGxBcDZLUU94TTcvZGNnT0xZQ01naExVcUpaZW8yb29BaWxD?=
 =?utf-8?B?VUJhREJXVFlOdU82L2EweDBRcmRMdEZFbGV6clIxcFlyek4vMW5PUndWcG1p?=
 =?utf-8?B?U3FZaUI0R2VyY2xWYVlRci8vVjBQUVhOK1JNVDFMb0FmUmsybzd5ZlhqNW5J?=
 =?utf-8?Q?VU4z5V5xlnlbGTdkRrEvyuF4NAJhKeYfn96YJyy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466785d4-4a85-497c-1cbd-08db66320374
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 02:01:59.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3HKSnjZG+3moMgmDQmkBGgLZO7o2XL+srwlERhPJM/H8ee31SRxIX75Ej/lY1eKRjp/5a8mQX/b6Gy8i47JyoPCpek2LYrdYwaS3Mo/80U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060017
X-Proofpoint-ORIG-GUID: xfGtnFe5BAgga85BYe2G0wqdAjJilStX
X-Proofpoint-GUID: xfGtnFe5BAgga85BYe2G0wqdAjJilStX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coiby,

On 6/4/23 7:40 PM, Coiby Xu wrote:
> Hi Anthony,
>
> On Wed, Apr 26, 2023 at 05:08:43PM -0700, Anthony Yznaga wrote:
>> The PKRAM super block is the starting point for restoring preserved
>> memory. By providing the super block to the new kernel at boot time,
>> preserved memory can be reserved and made available to be restored.
>> To point the kernel to the location of the super block, one passes
>> its pfn via the 'pkram' boot param. 
>
> I'm curious to ask how will the 'pkram' boot param be passed. It seems I
> can't find the answer in this patch set.

The pfn of the super block read from /sys/kernel/pkram is passed to

the next kernel by adding the boot parameter, pkram=<super block pfn>.

The next kernel picks it up through the early_param("pkram", 
parse_pkram_sb_pfn)

in this patch below.


Anthony


>
>
>> For that purpose, the pkram super
>> block pfn is exported via /sys/kernel/pkram. If none is passed, any
>> preserved memory will not be kept, and a new super block will be
>> allocated.
>>
>> Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>> mm/pkram.c | 102 
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 100 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/pkram.c b/mm/pkram.c
>> index da166cb6afb7..c66b2ae4d520 100644
>> --- a/mm/pkram.c
>> +++ b/mm/pkram.c
>> @@ -5,15 +5,18 @@
>> #include <linux/init.h>
>> #include <linux/io.h>
>> #include <linux/kernel.h>
>> +#include <linux/kobject.h>
>> #include <linux/list.h>
>> #include <linux/mm.h>
>> #include <linux/module.h>
>> #include <linux/mutex.h>
>> #include <linux/notifier.h>
>> +#include <linux/pfn.h>
>> #include <linux/pkram.h>
>> #include <linux/reboot.h>
>> #include <linux/sched.h>
>> #include <linux/string.h>
>> +#include <linux/sysfs.h>
>> #include <linux/types.h>
>>
>> #include "internal.h"
>> @@ -82,12 +85,38 @@ struct pkram_node {
>> #define PKRAM_ACCMODE_MASK    3
>>
>> /*
>> + * The PKRAM super block contains data needed to restore the 
>> preserved memory
>> + * structure on boot. The pointer to it (pfn) should be passed via 
>> the 'pkram'
>> + * boot param if one wants to restore preserved data saved by the 
>> previously
>> + * executing kernel. For that purpose the kernel exports the pfn via
>> + * /sys/kernel/pkram. If none is passed, preserved memory if any 
>> will not be
>> + * preserved and a new clean page will be allocated for the super 
>> block.
>> + *
>> + * The structure occupies a memory page.
>> + */
>> +struct pkram_super_block {
>> +    __u64    node_pfn;        /* first element of the node list */
>> +};
>> +
>> +static unsigned long pkram_sb_pfn __initdata;
>> +static struct pkram_super_block *pkram_sb;
>> +
>> +/*
>>  * For convenience sake PKRAM nodes are kept in an auxiliary 
>> doubly-linked list
>>  * connected through the lru field of the page struct.
>>  */
>> static LIST_HEAD(pkram_nodes);            /* linked through page::lru */
>> static DEFINE_MUTEX(pkram_mutex);        /* serializes open/close */
>>
>> +/*
>> + * The PKRAM super block pfn, see above.
>> + */
>> +static int __init parse_pkram_sb_pfn(char *arg)
>> +{
>> +    return kstrtoul(arg, 16, &pkram_sb_pfn);
>> +}
>> +early_param("pkram", parse_pkram_sb_pfn);
>> +
>> static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
>> {
>>     return alloc_page(gfp_mask);
>> @@ -270,6 +299,7 @@ static void pkram_stream_init(struct pkram_stream 
>> *ps,
>>  * @gfp_mask specifies the memory allocation mask to be used when 
>> saving data.
>>  *
>>  * Error values:
>> + *    %ENODEV: PKRAM not available
>>  *    %ENAMETOOLONG: name len >= PKRAM_NAME_MAX
>>  *    %ENOMEM: insufficient memory available
>>  *    %EEXIST: node with specified name already exists
>> @@ -285,6 +315,9 @@ int pkram_prepare_save(struct pkram_stream *ps, 
>> const char *name, gfp_t gfp_mask
>>     struct pkram_node *node;
>>     int err = 0;
>>
>> +    if (!pkram_sb)
>> +        return -ENODEV;
>> +
>>     if (strlen(name) >= PKRAM_NAME_MAX)
>>         return -ENAMETOOLONG;
>>
>> @@ -404,6 +437,7 @@ void pkram_discard_save(struct pkram_stream *ps)
>>  * Returns 0 on success, -errno on failure.
>>  *
>>  * Error values:
>> + *    %ENODEV: PKRAM not available
>>  *    %ENOENT: node with specified name does not exist
>>  *    %EBUSY: save to required node has not finished yet
>>  *
>> @@ -414,6 +448,9 @@ int pkram_prepare_load(struct pkram_stream *ps, 
>> const char *name)
>>     struct pkram_node *node;
>>     int err = 0;
>>
>> +    if (!pkram_sb)
>> +        return -ENODEV;
>> +
>>     mutex_lock(&pkram_mutex);
>>     node = pkram_find_node(name);
>>     if (!node) {
>> @@ -825,6 +862,13 @@ static void __pkram_reboot(void)
>>         node->node_pfn = node_pfn;
>>         node_pfn = page_to_pfn(page);
>>     }
>> +
>> +    /*
>> +     * Zero out pkram_sb completely since it may have been passed from
>> +     * the previous boot.
>> +     */
>> +    memset(pkram_sb, 0, PAGE_SIZE);
>> +    pkram_sb->node_pfn = node_pfn;
>> }
>>
>> static int pkram_reboot(struct notifier_block *notifier,
>> @@ -832,7 +876,8 @@ static int pkram_reboot(struct notifier_block 
>> *notifier,
>> {
>>     if (val != SYS_RESTART)
>>         return NOTIFY_DONE;
>> -    __pkram_reboot();
>> +    if (pkram_sb)
>> +        __pkram_reboot();
>>     return NOTIFY_OK;
>> }
>>
>> @@ -840,9 +885,62 @@ static int pkram_reboot(struct notifier_block 
>> *notifier,
>>     .notifier_call = pkram_reboot,
>> };
>>
>> +static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
>> +        struct kobj_attribute *attr, char *buf)
>> +{
>> +    unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
>> +
>> +    return sprintf(buf, "%lx\n", pfn);
>> +}
>> +
>> +static struct kobj_attribute pkram_sb_pfn_attr =
>> +    __ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
>> +
>> +static struct attribute *pkram_attrs[] = {
>> +    &pkram_sb_pfn_attr.attr,
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group pkram_attr_group = {
>> +    .attrs = pkram_attrs,
>> +};
>> +
>> +/* returns non-zero on success */
>> +static int __init pkram_init_sb(void)
>> +{
>> +    unsigned long pfn;
>> +    struct pkram_node *node;
>> +
>> +    if (!pkram_sb) {
>> +        struct page *page;
>> +
>> +        page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
>> +        if (!page) {
>> +            pr_err("PKRAM: Failed to allocate super block\n");
>> +            return 0;
>> +        }
>> +        pkram_sb = page_address(page);
>> +    }
>> +
>> +    /*
>> +     * Build auxiliary doubly-linked list of nodes connected through
>> +     * page::lru for convenience sake.
>> +     */
>> +    pfn = pkram_sb->node_pfn;
>> +    while (pfn) {
>> +        node = pfn_to_kaddr(pfn);
>> +        pkram_insert_node(node);
>> +        pfn = node->node_pfn;
>> +    }
>> +    return 1;
>> +}
>> +
>> static int __init pkram_init(void)
>> {
>> -    register_reboot_notifier(&pkram_reboot_notifier);
>> +    if (pkram_init_sb()) {
>> +        register_reboot_notifier(&pkram_reboot_notifier);
>> +        sysfs_update_group(kernel_kobj, &pkram_attr_group);
>> +    }
>>     return 0;
>> }
>> module_init(pkram_init);
>> -- 
>> 1.9.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>
