Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449526923AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjBJQvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBJQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:51:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631A11E8D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:51:50 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMZCU001264;
        Fri, 10 Feb 2023 16:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rEk+2FPdZtF6pA7NDFhdMwUDeMezCOAutxhyLHjYvwY=;
 b=BA0OwuWnd7Fqv+21PcNqwgVbVmLWhfxc88JFzN/Wm1hSBuQ6Wb48o2AZ/etC00Pcr0Zh
 UCyIpLG7Vr44tvLaJgwgtqRWzourQfDFWFZa9kfb5BpDINan4CEYYRZAo9FHxcVq4M/s
 U2vUqIn9WpeSKDQRaut0fzxiq1ObYrMAKemmZoLm8qeFk7vZESKtwQruvEB7mP72pdbZ
 CcsCnXcgqOh5Z+bVBjrFsWcvII+IZLly/5QM47MUPW/QhXNtd05hMhTgOC4L9a32GbcR
 ZtI5W8PQFt9bZ9jYMz6fnncnoPuGImRkY3su+qhQhp+vOpzdLmFzKl2az0PPPIt9iAkH Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy1duah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:51:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AFjTZE002663;
        Fri, 10 Feb 2023 16:51:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdth1u09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EilkI8xneqkrsmFltrEgJq9+S+/fXNtBshaYi4MC9yUt81DmbRu0SxjNjHhATvzCgYNs2FHXxgHIMIS7wjEDfGFVmlP4EDqJBFunRpHUmjV5hYk4rJfQoMg5TIVdut2QPko13Zg3nQo0JIPrAnyE3NzHhKjIlqM7OP21oHa1kWXzKtRk6nvAxt1CJPqlrN7T/MV48fbqcBOYDgoS0uLhhwe5IvaE3TRy/G4dDBEC0mmGfCorv+zz3AlBAAdSQVNHKW5YHHr5/izQOpsBahfff1QnAAhOis9G11iTOghkI7qij/azggwW7Lx0BVj02EPO/efumvgwqJUGpI5GrCAOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEk+2FPdZtF6pA7NDFhdMwUDeMezCOAutxhyLHjYvwY=;
 b=hLh6/47mWSfn5lUxxoU5ri+0QPIKG6WuS9WBoxt1lYHQNaZNIjjbCSqV/EkoPK0FwaS10+XgKkSvIVRZX+6Az6xOMbXnQK8B9s5ceRq0bbltX3qgHj6VXDCaNYCHM/ydNjqd9lJ8yYdNwsGJMOe5CPrGxdCUGDDTJzSuF722lj4G9lM/HKnQBgRdOfuj+PMWpGh8EEaY9kcZsgwpNSNYlHEqbDnUOn0cBfZXH7sJtv4A1oTGFHjQl8TEGgWs6vYzYObRetkSjuTXHg5x4p+G22GixGF44JpZD5AWrKG3LY4ZE/ADQEyHdrsPZ8xLhVazVv4nEoIgoNoyFRW75VWBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEk+2FPdZtF6pA7NDFhdMwUDeMezCOAutxhyLHjYvwY=;
 b=oaVDPVaU6xZ8Fp5F/HqNcXilBG8EL1F72Q8XxiinQ6NtbwnGGcMVxHvsdLnwZhnVYoYaRoIkAlCL6fKQs4XXjldrCp4h4wSdaguYFHsOF2SAp1MSUp0Oa7/ftuWAMwCmu2bI/+O5eCYiuo8Lu0GFlunCY6aZcIxLBZxaIXZ7gW0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SN7PR10MB7101.namprd10.prod.outlook.com (2603:10b6:806:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Fri, 10 Feb
 2023 16:51:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%5]) with mapi id 15.20.6111.007; Fri, 10 Feb 2023
 16:51:20 +0000
Message-ID: <99bb0514-61a2-db5f-5cc8-bac5e4283d19@oracle.com>
Date:   Fri, 10 Feb 2023 10:51:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-4-eric.devolder@oracle.com>
 <dee53091-3aff-29f5-c7da-510d315ddcf2@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <dee53091-3aff-29f5-c7da-510d315ddcf2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SN7PR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7658b96b-70f3-45bf-55ab-08db0b87092e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jmZxW/uQ44IBMtDG+wzPB8rfEhBLbXnZN1JQrwf8+6lVZr4mJH8IyqSqw6XJ+mUl2tToTk5gFNf0nroav3f3BYNpwq3hYD8gsdp0JLOpjW4iOzTKqsyoZ34bDWV85hCveE2Mv3EAkYlri7UES9rEKFHB2QBSaNA+XCNAn9WQc/00vyRnpqc84FeCpcRRvOyaqPTpBCu7oNXWhkwkn+SyyG0aaZmBF+SjPYXdPE+Blp4EcS2VUk2bQ8BSXokBBpKLdR4jdHguvPhDSauZlcpfWO5tB91ePF9+1RWYVUFBHF2A/7ixKO/tbUCcbsUG1ZRPtUflr3QjQmFNzuff0Prt7G8iOykWh7CXW9/rnsV6YfxezrwbBU/ydAgCc/p+Fue2xBdPowiTSDd5AkzBvOeNAqa8XjT4/HxTZq68m0rwFn1n8z63rjRHg+G4B3GjFgQTRS40DcGDLaFaCiup/6I3CG/A50u/C0+aemOz3L+6w1VJkn5tsxdD5WAc+f5TUSbqARVN1t0pMtv+n0Ckmn9F1C4vMK9cGtynuSKge6sTZLDAEMP7j4WXxpxk9p4fVPjRXCBMzqA6bldXsBpvdI7jMtuMPPJvEP9bPFY+bTVJNjhKjk3ShoGuXthJ0+0qTtpLI3nSMZ+woD9DbDTGcRprZtETtAO7yRWpQVNgB20TJGgK77Q7nfiwvfT5V3FBdJDVe39KZGhtktPo9Xlb+tquubjPjeqjVE3fWdIcPszr9gVkik8kSOKYovyY7UoQnuU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(478600001)(6486002)(316002)(2906002)(4326008)(66476007)(66556008)(8676002)(107886003)(66946007)(41300700001)(6666004)(31686004)(6506007)(8936002)(7416002)(5660300002)(186003)(53546011)(6512007)(38100700002)(2616005)(36756003)(83380400001)(31696002)(86362001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9vZ0VZM0MvOW44SmwyK09JTTRPand5VERUV0pkUURtSlc4TGlJeVMyNGVB?=
 =?utf-8?B?QU9VTXFKemVQUzRGR3Zvb0h5czYwTmFQcTBvOGFydUVOTUNxQk1GVzZUM0VZ?=
 =?utf-8?B?Nk5JcGgwOWxZcVRkdms4RmI3WTZZbzl2aXNGWCsvTDlHL0ZWZ2x6UjV2YS9J?=
 =?utf-8?B?ZjVPZkUrMmtvdXl3RU8xd0xteERYVGNFbWc4NTZqV2E4Y1EwMWF2ZWhxZi8r?=
 =?utf-8?B?WFlxK0l5eFRhM3BlRDNDaDk0MEJYeE1lMUpsT0F1K3k4QXNUTHhVN2E5dzRz?=
 =?utf-8?B?dVBMOUZHYUR5WHBxYWYreXdDc0pMS1hHZ1FOMDE0YjZxTGp1NXlya0Ztdi9H?=
 =?utf-8?B?RjlKaG5xcUMzWll2VmI0T2tmRFZ0TVZ0eWZVNlhIRDJUZVpTY25wa0F2VGtV?=
 =?utf-8?B?Mk5NbE0vUDFOWXFoTmNJemEwSU5jdzIyZnBET0plaWJQWk5FUlY0dVJ2Mncv?=
 =?utf-8?B?U3VFNTVTeFZPRmtFRDZFd0ZXSGtyVjNxc0M1Z3g4elZ3cjJXeFdFVTlZTitK?=
 =?utf-8?B?bTRjcWZDVTlzanBGMDNwajFRY2x3SUJ1YVIyS3JPZzI0NjdrTi9ORmlubHE2?=
 =?utf-8?B?djZnR1MyNnF5SXljWHMvRzN2ZEhGc1ZXQkFlR3FCLzRlNlpvSS8rMjFEelY2?=
 =?utf-8?B?azlvbVlwZFlqRUZDa1ZSRGJ1K2F1WFNESGwrazBSRmc0Z1BlSDRtMTM1Qzlr?=
 =?utf-8?B?b2doZUNFREJMNGd1SEtVSFJnK2M4UVdkOVVJTHczRWZpT0I0NXBCRTNPNVEy?=
 =?utf-8?B?RlQ1RldrSUEzZ2pJeWNpemNjQzFYT1FMMzQ1MTFLdjlBUjg2ajVZeDEvcXpl?=
 =?utf-8?B?clVFdkhuRXAvQkQ1Z0NMY2I1QXhCOHJOeWhaakpIR3BHQWRPb0ZLR0RXZnBa?=
 =?utf-8?B?bTFkQVV2dnFjWUNzNjRRNEg0bXV3TkcvSmtRQ3FMR0VxRnIwY0IvRnNRL21q?=
 =?utf-8?B?d1F5V3hHWHhqdG9BUWFOUTVxVzZzRUl0RFBaY3U4cWZhY3BCN2xrSjBEVDNU?=
 =?utf-8?B?c01EOTFkejlyZUQ3Z2UrUkVnY1BsWHF6cFdWODBPSGJMRTZudVVjaXFQOE5Y?=
 =?utf-8?B?UjQveHNvbHpONDhleDZvR3pGY1ZUYVd5YWY4YXFvVVo1TERjU2xpSGIyZDRj?=
 =?utf-8?B?WkU4Y1VDNWRWUVUwVERjdTVUa2QxdEY5RDhoT0pTNkRsbWJqY2ErWlNuSVFQ?=
 =?utf-8?B?L0dHQkVUWjVwR2M0dWF0ak9WcVk4UXRCenBkclhnNUw2ZkVNekZSVEpidytP?=
 =?utf-8?B?WUtYTWJ3WGpjQXd4UTJaWUVhQ0VNRnZrRHo5ZTRyYUk5UUc2Y21vc2hPdFpL?=
 =?utf-8?B?N1B1cXRpYTlzYnppbG5TM3BXK0hJcmR6NGFjQW1HVGV1M0hKN2tZaTVZVlVP?=
 =?utf-8?B?eFd0cDNPbXJpODE5Vm9IeWhNRmdIUldlVDk1WmRBbzJFRjJBNHZOTzRaY0xQ?=
 =?utf-8?B?Wll0emlnK2ZhM2l6cEZ3VE90TnpzL0ZPZ01wbjdMeVVVVGtnQ01CeFFTYW5i?=
 =?utf-8?B?c0hKVU5lMUdTd3dQRUYxQjFudDZUWXJkc0trTTJVdkQ3b2J2NEsrTklhVGtq?=
 =?utf-8?B?d2dWNXdOYlloWHhZK1M1YTVJQXlNMHM0WU8wTlJUUkJPSzJwc1FSSVJHdzFI?=
 =?utf-8?B?R1FGWGhaZFRFSXZaeGxOMjE2TkxNQTIycFBDY3lpOTRWWG5EL2VhY0pUaUlK?=
 =?utf-8?B?WHMvTWpmeDdSR1VrR3VFazF3ZkFYQ05iQkphd2U5N2dPckMyNVRGVjVZakNo?=
 =?utf-8?B?Z2NqYTNYeTBQaVBoeTZCTFFENHJQRlc0djRCaVZhZHdCckZFd0JhajMvQXhy?=
 =?utf-8?B?R25aQnhoOGJwVi9KeUZZNk5TZHdMRElLZkwyaHVJTzliME1UUEhwU1hHMGwx?=
 =?utf-8?B?Q2V1WGpRY2w3dGlzNEtQQ3lva2xIeTZPV0VYMTlORTBVWWk4Y2thdjhKSSs1?=
 =?utf-8?B?N3BuWnVVb3RNTFJKeUU4Nm9qZG1VMloxMmZpUWFnM3hVZFV3d3FiRkxzVjBQ?=
 =?utf-8?B?RFJYSnJSVjE0SnBFd01qUlh5SGJlZmdSNXhzVDdtZTMwc3JINnF3QVIwUDVn?=
 =?utf-8?B?NDFRRTJYak56WEV4K1NOOFhPRVp2N3RlRFN4ZnpBQ2tKMGRicjZaUnYzemNO?=
 =?utf-8?B?UHdwL0dUWFZLVXdpMFlraWVxZSt6K01jaFhQeFlIeGNHL3lIM1FFcllFcits?=
 =?utf-8?Q?EaFSoS7tk5PQNNGpDBvkYCI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S1J5YUp3enZueFZBMzR1S0dZQXkvTVVacHA5WEZ1TGIvamVvRFdVSW9HODUy?=
 =?utf-8?B?Y0VsT003Q29aTjNjYVlubXhpblNLK3ozNEZ2WnpTRkN2b245RmxKUHdRRDU2?=
 =?utf-8?B?Szh6N3ZENkR2YVR4L0tzZ2EvQy9NcG92T0NqV2RXUGJnVjdHYTFVVThCcm1W?=
 =?utf-8?B?YlVuY3drbVFiMzVWUit2V04rMHRwQ0lTNE90ekxiNGlHVHExQ3JOOHlWRk5P?=
 =?utf-8?B?eUVCTjhtaG1oQlgyM2wwUGJyQnpLL29XVWhGSU9QYjdzMWxxZUVURmMxSW1F?=
 =?utf-8?B?b3NmUDJUZExSWm9VQWxGYkp5TTM2NEQwZ0MxbFJOSW9abmdqWTFZbkk3WTY2?=
 =?utf-8?B?TlVTN3NCOTl2cEdCRm5aUWxCVDBaclVoNGYvV3BHUUZFZm91YlhqS2N0QmRm?=
 =?utf-8?B?N3kwWEhZL3VGOFhRNXJxY0VjL0VlVDk3L0ZxcGJBMGZvZmp1VDZ0cjFoQkV2?=
 =?utf-8?B?S3I2U08xeElBcDYzMmF5Z3hPUENKbHBsT2dvQjZTdFNHTWJDd3dVVHM1cmNP?=
 =?utf-8?B?RUFZN0F2ZTR5UVFuNXVTTXlxa3dabFQ4aGlTYWw3RFlDUEhWdzExUEh6azFR?=
 =?utf-8?B?bThnMFpjbkpTclJhOFZPa3NSSnlvRkhEVXAxbmtEKyt0K0lkTXk2aURoNTJt?=
 =?utf-8?B?NHdpaXVULzRxYVliRWkvanBHMzYyajFwU2crYzlCK2s2aUljL01waWIzU2JL?=
 =?utf-8?B?YmFxaStzam1lSW5Tb0N3b09uQVEzRnpVWFFvN01YSG03ZzVuY1NJN3JMeThn?=
 =?utf-8?B?U1d6Um1IRXQrdnBaVlZ6WVpyZTFaVkxCZCtPTkQ1c1NBakZHczQyandyTEFk?=
 =?utf-8?B?ZGU3dEhja09GT1FSRmVIRVRwOWhrSHEzdm8zbmNCVW8xcW1XTnNYVXlFMEow?=
 =?utf-8?B?N0dRbEZmczk0M29jeXBTTmxud1NYdjJFWUY2dm8va1RFbVRQNkJqZ3pta2hM?=
 =?utf-8?B?QWZxNHNxYndFaWhmY1Y3aUhhbFQ5Zk42VStuVithN3JPMElEcGpGaHlqMyt2?=
 =?utf-8?B?YzdJZ1lCSlc4SHgrcnp0Q2lPeFJMTHlYb2s5U3VObTBnMTR0VWV3dHpzUTdi?=
 =?utf-8?B?aDFlNFRxTGJmYmNQNUdicmxRelFZUW5LVkVjeTl4bU5RNlNkVTdTbUpjYU9t?=
 =?utf-8?B?bk9tSEY3SlYvTTJrUzdnMWs1cmR2eGxRbDhqUi9mbG9tTE9jelJicG9pTWJC?=
 =?utf-8?B?Wk4ybTFyM2tSNi90aUFnYlNSbk5vUVV6M2oydjgxeXBxaHh0NzJiMHNyQ2xk?=
 =?utf-8?B?UTJNOUZFMW5EWEZtRHl2aGdwbEp5bi9PZEd4b3I5dms5ZW44RkN3d2hvYmhT?=
 =?utf-8?B?R0RGalZRM2N3a2Z3SFpaUFZmS3BBdkdaSEhWMVpBbm9FRFgzOGFOOThVejRD?=
 =?utf-8?B?WTdBU1c4OUdWdmFuSi84SUNtdGpENmlESWcvSE01bkNsWXZrUzRaZGpnSzM5?=
 =?utf-8?B?VFhkb0lTUjZPaTRnSTEvN3hPK09TMzBKMmhHUWoxNjlSejBzc0ZYUnRodXZl?=
 =?utf-8?B?Ym84OW5rRzg5Smx6bHZCQVB1aVVKNG9pSjRHSlJxcDVpZU5TaVBIekFtcFIr?=
 =?utf-8?Q?NoO3+mWorRfLAaTcpjoXJ01tE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7658b96b-70f3-45bf-55ab-08db0b87092e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 16:51:20.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9vdyTexiIu6QXCkihVX9OHgJLhuHBt2bkUctXDxb6alarmr8apMtD+hpQ8Qt8SbbEoxo1xffkon9xVRdOhlAgd+n0XJo2IpJFqocAl1W8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100140
X-Proofpoint-GUID: 7aTshYmT22sddP9izzA-NBsz3LV_gKDw
X-Proofpoint-ORIG-GUID: 7aTshYmT22sddP9izzA-NBsz3LV_gKDw
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 13:10, Sourabh Jain wrote:
> Hello Eric,
> 
> On 01/02/23 04:12, Eric DeVolder wrote:
>> To support crash hotplug, a mechanism is needed to update the crash
>> elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
>> onlining).
>>
>> To track CPU changes, callbacks are registered with the cpuhp
>> mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
>> crash hotplug elfcorehdr update has no explicit ordering requirement
>> (relative to other cpuhp states), so meets the criteria for
>> utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
>> state and avoids the need to introduce a new state for crash
>> hotplug. Also, this is the last state in the PREPARE group, just
>> prior to the STARTING group, which is very close to the CPU
>> starting up in an plug/online situation, or stopping in a unplug/
>> offline situation. This minimizes the window of time during an
>> actual plug/online or unplug/offline situation in which the
>> elfcorehdr would be inaccurate.
>>
>> Note, that when a CPU is being unplugged/offlined, the CPU is still
>> in the foreach_present_cpu() during the regeneration of the
>> elfcorehdr. Thus there is a need to explicitly check and exclude
>> the soon-to-be offlined CPU. See patch 'kexec: exclude hot remove
>> cpu from elfcorehdr notes'.
>>
>> To track memory changes, a notifier is registered to capture the
>> memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callbacks and memory notifiers invoke handle_hotplug_event()
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event() to update the
>> elfcorehdr with the current state of CPUs and memory. During the
>> process, the kexec_lock is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   include/linux/crash_core.h |   9 +++
>>   include/linux/kexec.h      |  12 ++++
>>   kernel/crash_core.c        | 139 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 160 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..ed868d237c07 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>           unsigned long long *crash_size, unsigned long long *crash_base);
>> +#define KEXEC_CRASH_HP_NONE            0
>> +#define KEXEC_CRASH_HP_REMOVE_CPU        1
>> +#define KEXEC_CRASH_HP_ADD_CPU            2
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY        3
>> +#define KEXEC_CRASH_HP_ADD_MEMORY        4
>> +#define KEXEC_CRASH_HP_INVALID_CPU        -1U
>> +
>> +struct kimage;
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 27ef420c7a45..a52624ae4452 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
>>   #include <linux/compat.h>
>>   #include <linux/ioport.h>
>>   #include <linux/module.h>
>> +#include <linux/highmem.h>
>>   #include <asm/kexec.h>
>>   /* Verify architecture specific macros are defined */
>> @@ -371,6 +372,13 @@ struct kimage {
>>       struct purgatory_info purgatory_info;
>>   #endif
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +    int hp_action;
>> +    unsigned int offlinecpu;
>> +    bool elfcorehdr_index_valid;
>> +    int elfcorehdr_index;
> 
> May be I am reiterating myself but I think we can manage without elfcorehdr_index_valid.
> 
> Here is how:
> Initialize the elfcorehdr_index with a negative value in do_kimage_alloc_init
> function (it is called for both kexec_load and kexec_file_load).
> 
> Now when the control reaches to handle_hotplug_event function and if elfcorehdr_index
> has negative value find the correct index and re-initialize the elfcorehdr_index.
> 
> Thoughts?
> 
> Thanks,
> Sourabh Jain
> 
ok, I'll eliminate elfcorehdr_index_valid.
eric
