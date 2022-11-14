Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886C7628C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiKNWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNWYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:24:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E359FAE7;
        Mon, 14 Nov 2022 14:24:23 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AELEq3L002751;
        Mon, 14 Nov 2022 22:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GgNLbRrKUhcGECxl737HVOrzL0RvP+ORLHBgsorcxXM=;
 b=V480qvEtFMcNzg7u7ypHtdSwD5TlzGyAooMQlib4YW28v3mqM0yvv2VUfbJo/YjaiV7e
 8XokXQWwpxfEYOAaaAUycUVCTRGrtK/I30IK4YQFzYnzr2rPJEDLdolAF0u/7e59KSSH
 kTG86tAtxEVw4Yv5YFN5ErfIZEkifaX7sUjNf4uCNkafsEC8OLDBjx+CYWWrVzqBMR1t
 u3bgXGwsSdCNMb25vxOxI+ROEwbvt/EPhbrjOdrH+o069T+5/2dyXl8ECF2sYVlT0lYm
 /JQ+tiSWtIMkMdAmJgzfw+GxzO2095QGyMvUrKzDw5jMvJ/mlgQWZtd1N4qANxu0p+aM Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kut2d8wwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 22:24:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AELeB07035179;
        Mon, 14 Nov 2022 22:24:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x4t8qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 22:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PipZxgGH+PibjqAgtmHosQWl5b4CkAloBI/UW2pmTQ0Lm7+t0f5e/JWs246Q9/kYW5AV0yOfLcZ0pfKcHO5sYzXNc3ZKR4MCyn2K+VLbONAEAu6NhlExOe2gcVFNkVWNy7nXbJBFMfP6Doa8y8M4f+OSkaQkCBsREZJXJ7wrYTRCHbhIs/66aKo1Mq2O+mfAQKvAQhO9bVCxCzuwjs5hUwfSa6QJBsOlLFhdFZ7owEO8mB+U78rKgDbHfAXGbQhF2j+WEW9QJk0eNo72wfFsnzZeA4xP5oaMp7n5sJ5V3zb6PgZp50fqg3wbhlSWAgGJSiEhFWXbk78barl5g7OtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgNLbRrKUhcGECxl737HVOrzL0RvP+ORLHBgsorcxXM=;
 b=e+/Zc5bjYxyzbua6a4NjG1abdH7kXKwAf8ipgdYIrUwOU38lVhK+NJysiRcfY/gRD7rBaJkvQG3L0CFopBw8ndU16tDKnNhRdQx409/fOU+KX9pH8Nsqp3jonsE3GPpnyd9do8qnYbh0G660ES291pvnX5uEm6FX1DAt6dtSwLi6bR8Y7MkJhyl0UJzVCNa7evKsdfEkvLIA3+UOQDxW7u9WdGNJR6qMVcNfcKvUyUKY0FC1hwgeu997zNkMQng79moARIOmac5zUaObj8fTlwMRJwtnpGPIsiyfNpHKgQNURnn1xCQ5ev123fSazVXuWnkjxCyXBzERihz8LOTFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgNLbRrKUhcGECxl737HVOrzL0RvP+ORLHBgsorcxXM=;
 b=DdAgSc9yOoZJh0nZZW0QrDanJVeZOwa3pscP9z7EoL3fcsqrsRbFm1GuMhMlqAvF1c33YCXoyVubh7g1qmSDZju6mGc8SWhengRddvrLYgSoDgBlN2bdjoAaR1WHZF07f9BDLKhcD4fIh5X4ZTQ+QwsWrqeNVQFZNWbVanNzglM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB6283.namprd10.prod.outlook.com (2603:10b6:510:1a9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 22:24:00 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 22:24:00 +0000
Message-ID: <ca3a88b8-da56-d78d-1c01-6d4b4ea6f8d7@oracle.com>
Date:   Mon, 14 Nov 2022 16:23:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] scsi/cxgbi/libcxgbi: make sure sg is present before
 calling sg_next()
Content-Language: en-US
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        Nilesh Javali <njavali@marvell.com>, Wu Bo <wubo40@huawei.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, yc-core@yandex-team.ru
References: <20221114150923.3544796-1-d-tatianin@yandex-team.ru>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221114150923.3544796-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:610:54::17) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH7PR10MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 551956c1-47c3-4e80-33c2-08dac68eedb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDThhUwCYRnCM9bliZJWmM/w3l0XTySH796g2bkRT3kVfi0kS3CwX51XdaaAY8Kv2WqQYnLmoXq3FvxDP+sOHzV5CI7l3Y4h1+uNhQRgXVC7HcBTdpGkNaqV1ASHsVvD9sO5mP9VaMiEHYf298sIWzE7bj1F6IemX2N9EClafP7yrX0pRqO0FrldKQqXvQ86w80yJnvrOfT0gpZkVBXmbu7GjNF7J3axvGd2MWqlK3yMhJ6x4/MVYRi+AP/J0vqcDpdV/4RxHWnvfJV0JaFvNMa6h+58WfL6kBvr8C9F626er4RL6Ci5oLFr4cpfqtTg/mWN+OyTYfS3b4Ys+XT+eJFKX2CyERWS4NW4KSI0AEPp0jstAov+Zx4RmXpNsBGP8v0hs+F84dW1SDLl/N9lsY+1i9qChUN/suAnEXyBwF+0xgf5YH/e1UKQI0jxtec2H9+fuAJ9x+MBnzrlLKo30geY+fWMI6mZxi/XFZl4obcLNgH7xNEJEGtXDc8S11oUaZDvN0X5CL/uJgvzM3GlvS7MW+ptFbMf3GejfLKM8ncl+cd5OxwRe5sJtFrOLSXX//i65501qlS8msRqgn1QSBAH4JNbTMgBCJ0qfLbOg52SM2T/hudXBLtnUtCaYz9pqOtktDFVEOQetJjoDqFW6YEkQd+Rn2fhsN+Mcoh924pCQJ7WwQ/0eBZ4A+G/zfpn3bmjkzRQ6Ck/Sl2XTBtRtEnJA/CB1JNkkccIRP4Nl/voncZyU/QkHay4aQKbxmPxTFYZIC2EykBYS65tlpMTA31ijWPPTePMdV2tZxJMtjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(83380400001)(186003)(38100700002)(2616005)(2906002)(53546011)(8936002)(4744005)(6506007)(478600001)(6512007)(66946007)(8676002)(26005)(4326008)(66556008)(6486002)(41300700001)(5660300002)(66476007)(316002)(54906003)(110136005)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhYQk5kUWRMOVpnYlFTOUc2RmFIdERjZ09yTGJTd0Fxa0lVMlZQbXA4TElm?=
 =?utf-8?B?U1ZMTWVieVl0T0s4Nkx4QzhtYUd0c2pPeWIvd0o3SExzOThjcW92S3c3bWta?=
 =?utf-8?B?WC9zVmM1ZmRLaGQ5aFFUaXhXSFREbDl4cnliQ3oyOVZWUDkreUN4Sm1Qc3Fh?=
 =?utf-8?B?d0JIMThBaGFUYW5TVWtuSkZFdmM5OXVTVmx2TFpFdGF3Tm9JK0VZRFMrZXNp?=
 =?utf-8?B?VTNpaS9saDE4NThqYlJVcXlVajJrWTViZGw0cEJUNTA1VkV5TW11Zm9CVSt0?=
 =?utf-8?B?S09GRjJuZXpHNHZ2WThrSVlETVVNRlYvTXpkeU4vbjQ2Ry96bEprV09HS0dq?=
 =?utf-8?B?RWF0cWo5dVo0bUdTRWxoaEZ0Q3FWcG5UMWJTTkFtaGRSWC9sc2NxbHB3K0sw?=
 =?utf-8?B?c1NjU0Zpd09pRjkxUU9qTGtoV0drQlJiVzU1elhHOFJkV1ZIcDB3TW54dUJ4?=
 =?utf-8?B?bmlhZ0M1MDFta1JBVkcwSURUaUdCQncyZHUrVEduZGhZa1IreW0wWVd0a3M0?=
 =?utf-8?B?OFZCdDBHNEpSNXhPc2tXQzVFTEphbzlPT05ucklQTlVHRGVxckhUTm1BMVlV?=
 =?utf-8?B?RE0yaUw1RXNpanRvTUNXa29QQ1BOWEZWL0x2NVYwZHpKUEtpWmFscllwN1pa?=
 =?utf-8?B?VGdyZGh3Qm5vNjkyK1ZiblR2UkNuUEpxYURxUUp5ZkhsSnBWQUVQRW1qTmw1?=
 =?utf-8?B?YzZ6eUtBa21pb1lNZVJvVWJ5bVEvUkFscDdRMnNvRlg5Y3hCd2Y5Z1gwWGkz?=
 =?utf-8?B?VFpaUzV3OE9hMms1dmxQZkZ3WHVvZ3AwdjBueHRxWjc1bDVoYUMxb1lJM0JT?=
 =?utf-8?B?dFp3bHIreWUwMk1WamtUMU5WUU4za29TQWMwcCs3K0pqQ3ZHN0l1MGtDOUJj?=
 =?utf-8?B?MFpoMXJ3SWhMSDQ3TkdUUHMrakd3YkJEaFR5ZURRc1VzY1dGZ0VHT2IvVjBj?=
 =?utf-8?B?YzVpUmF5eEYxUEQ2djdteUE2NlR3Zmx6d09BbmFQSmc1Wi95TVNVaS8vT1lH?=
 =?utf-8?B?V0JKQmxrYk10bHRsaXJqZ2w2YTZINHViTHluTjBqRDdGYmliSm1BZUlkQ0lo?=
 =?utf-8?B?cDhmekIvaWN5SG5ZeEZZWVNwYnlUcWhKM3ZTcml5ZXpLTFIrR0hDSjZXVjAr?=
 =?utf-8?B?Q1pSUERpelE5MDdmb1g1U0J0RDh4alFxS0NtMzZSYksrbXN1L3NvcEpmY0VG?=
 =?utf-8?B?QUg4NDVzN2hVYVgzNGtVUEZLNEZGZVYwS2tBR0dkQzVMckMrL3d4V1NPdWJl?=
 =?utf-8?B?Z1BOQjcrNTdZTmVIclpjKzdNbStnTzcwL1pOazhzREJ5c1MydEVpMHpGVG5y?=
 =?utf-8?B?bVYrazRMaVdQeFhUS05Yc3hVN1FtTkN1QithblV6UExSTnRnQjFVL0RNY3dE?=
 =?utf-8?B?eWgvajNOSGhYTk85MUNkWHZSVTFBUlQ3TE84RWJjdVBERDIxOE5JNTdaRjhl?=
 =?utf-8?B?R091KzBETTI1RjI4dElidUp1RmVXUnNjU3RpcjRINEdWL0orNGtGVmJVdHRq?=
 =?utf-8?B?dUJDNUxwVkU4Qjc4Z0NjSkhLamRYTkdRVmdPS2J1b0IwYmIvWk5qMVBXL2Nv?=
 =?utf-8?B?Z0EyWFlLMi83bEN4dGhScEN4ZDI1RUVzNlJQYzNWb1k5Z3A0cjlnbXp2UUVP?=
 =?utf-8?B?N0ZKTTh6WFNVVmZBc1g4RG15bkQ4a0dZajRjSkdzNkxubXBtOC9XYXBXYW1k?=
 =?utf-8?B?UzFIMmlJU0F3YXVSbGRSVXpERGU4N2xURUlEWHNCY0pFWU9NS1JvNTl2VW9O?=
 =?utf-8?B?em5NeHVMcEM3R2d1R2NZWXFrM0ZGckJtZmk2Rkc1Q2k3ZnRLcFB4a2xTeXNn?=
 =?utf-8?B?M21tN056T3hsK3lZazJzK0lXeFlwRXNuOW5Na0NJdHdtRStueUNCQnVUeGV4?=
 =?utf-8?B?dWxrWmZIb1BDbnJ2Y2dOeHVEeEpJM05jeDdvTEljZ0Fxczhvcnk4aFZEeXJ5?=
 =?utf-8?B?cjlNVUV6VEh1QldUbzAva3Yyem9RR2ZpVUcxWVl5WmFwazRJcngrNStlVmVi?=
 =?utf-8?B?K0hnemJGaFVxZWpaWkhsaVQ0Q0tRVXRqOC9DaWRoeXFRQm5KS2RwZ1A5Ujd3?=
 =?utf-8?B?dGttcUhjTnlrbStpbkZtbXE4RXk0MjVSbW5ERjhqelRLL0c3TmJJVVBxRDRF?=
 =?utf-8?B?eGZkVEVqYk5OYVF5eUtTNXJwYjVncTc2RFdhMHRQTDhUNDAzV0Y4UXJnVDYy?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZmxKbVBOMUwvSC8veWNGd3dQN1BMbzk0VHBYMEZKOWNCc1lVWXpIL3Jya2lL?=
 =?utf-8?B?dDRQMDRHUEljZnBhTVJSaVl4NWlWZDZuUGxYRTJISUJPcHh2ekdvZTNQRExR?=
 =?utf-8?B?Vi9sN2s5MUhTdWl3WVNTWG5IWXFJSnU3MmFoRFRHTGRqbkxKQXN3b0NwR3hF?=
 =?utf-8?B?WGJabzFlR3M3a3llTWFodDBUVDViZTJPd1JmTFFybTFDQkcwWmNsczJablBs?=
 =?utf-8?B?VWFLOVFkbmNLQnBmaVF4S3dWdzA4RCtvbnAwQlVPbVYyaDhVRnAyQ05yWDlw?=
 =?utf-8?B?Sm42QmJEZTd2cEkxMVdmUXdvUWNncWR0YzlFaEk2bzJrcmdFK2pxZDlKOHVo?=
 =?utf-8?B?QXZWSjlPU3Roc0dNd0YrTnp0Z1pwM3FNcEJ1RjRNUTBUZW4vQnl1R2JFRTB1?=
 =?utf-8?B?eDA0YXN2ZGJOSVRQSHBwc0xRNzM2QUliN2lSanhmK0drelFKY3NnVVpoUzFr?=
 =?utf-8?B?dVV6T0ZaU2RBVVRXUzRqc3ZKaWp6UkNjbmtUbloxcEZYRTBzbkhpN0Q5LzZo?=
 =?utf-8?B?VWdrSFEwODdIKzB5Rmt6cWxrU1J2YTFtWTNWMy9hd3VOYTRwRHErL01FWHE3?=
 =?utf-8?B?cGdZL3I3dXF1SXlIQ3ZJNmMxYTJyc0VmM0FadGtHelpzS1IzSUNPcFFEK205?=
 =?utf-8?B?YWU0ZDhUQks0dHlucFNGL2VGZEc2N0ZlTUxSOW52Vk0vai9xdldyeTlQdkJ3?=
 =?utf-8?B?Vm1tRGN0bUM5b3ZVL21icXI4V0xOM3JreFI2QjZITVlQSFN2My81UHBtQ1d0?=
 =?utf-8?B?VkhRTW91M2NIMU1OZUc5ZlNRRFNRUzlkSHU0NWp5QXJxSitleERiSFpsamcw?=
 =?utf-8?B?a1k2b1dKQVdMbW9ocGUxZkNFZXJnSHg2cSszeVZNcTZaclBzeDY0ZCtNV1g0?=
 =?utf-8?B?RWNXWlJobE9UUnJPOUNmbGVHQ3B2NHE2SE1VUHJBR24yNW9EQnFMZmpzcGI3?=
 =?utf-8?B?N0FIUVIzVWtGYlV6c2h2Q3Z3Vk8zdVZlMDk5WEtSMGJCYkRER2VKOXI1RWFn?=
 =?utf-8?B?SmJtZS93NmI4b0xnMGF1RDlJUExrT0x4MktUdjFuMHdtUnZ5dTVnOEJqMFEz?=
 =?utf-8?B?UkZaa2I2MG1iM0JmaU1GamJkL0NCMjhVWURIdGRENVdqN1lVT2laVzZGUEY0?=
 =?utf-8?B?c1NJTFp0MUdNTzRhVndua2Qrd3JJMnRIM28zTDNKa09wNXRLT3lldW85NHlm?=
 =?utf-8?B?UEE3YUtuOFFFWlZscFRoN2hTTTVrSzJoakxkWksvQ1Uva3dhaThScTJBaWtW?=
 =?utf-8?B?aFRzMFRBaElvaXA2VnJSbUIwZWxhd2V6OVZKazI5VDRNR0FJWDhGeExxcXJO?=
 =?utf-8?B?ZEJzM1IzZ1FKSjdIeU4xdVBzZTBaVnRHNFc1bE9hamxGWGZyQnNxTHpTRkk4?=
 =?utf-8?Q?iFCYWWR5+TG56Jjj0pn06X+UFpGFPJ54=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551956c1-47c3-4e80-33c2-08dac68eedb5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:24:00.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9pm9QNqLoHlAR2NtLA9WFZj9xF0KjApwrDle3YDJYdZjO7m+9YSGSM5A8Sa/kZjzjsuaVzaX1epoYhvnu4wO2K/JQp0zkdn12NgVi8xLu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140158
X-Proofpoint-GUID: Vmsxbx5jAvToDe4QNdECUHsbZgJ2nhtU
X-Proofpoint-ORIG-GUID: Vmsxbx5jAvToDe4QNdECUHsbZgJ2nhtU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 9:09 AM, Daniil Tatianin wrote:
> sg_next() dereferences the passed sg, therefore we have to verify that
> it's present before calling it.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  drivers/scsi/cxgbi/libcxgbi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
> index af281e271f88..2ff9810f42a9 100644
> --- a/drivers/scsi/cxgbi/libcxgbi.c
> +++ b/drivers/scsi/cxgbi/libcxgbi.c
> @@ -1196,8 +1196,7 @@ void cxgbi_ddp_set_one_ppod(struct cxgbi_pagepod *ppod,
>  
>  	if (offset == len) {
>  		offset = 0;
> -		sg = sg_next(sg);
> -		if (sg) {
> +		if (sg && (sg = sg_next(sg))) {
>  			addr = sg_dma_address(sg);
>  			len = sg_dma_len(sg);
>  		}

Is cxgbit_set_one_ppod the same function but it already has the extra
sg check? Should it be a libcxgb function in libcxgb_ppm.c?
