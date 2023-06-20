Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4B73757A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjFTUAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:00:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7341716
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:00:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGETB8018803;
        Tue, 20 Jun 2023 20:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KSc17VmV/HzpUHi1b1dq7oVU+9aGcasJLDG4dMbEVzE=;
 b=LoaaSMC/exD8+RgadBVij3jqIlnPIVn6J5iHZrWBwFTuDNyYG31mqQSVZ3gK3d7YiFUa
 n1q6K6lTpqjJ2+CYKLwwf3Ywmj1LdQjwtmpvB1aG8a3ZKcQbx8+UDZVQzaxb4LDjQ1iz
 FiCGb5qCptl2RGSU64T1va3onn1z/OC9Q1i4txZZu+56P4mm+pxEDioMsbRfLCT+j9kS
 aFcjiCN/jI2j3Vb2NmsdshujW5H9qUrP/UZo0kF3UJIeBsbGC6KgDXiSHbdWPHltgpvi
 ySCIpeiPYMrOOgvVaQKfILS5I8/vta2gKfR2y/SnMMHCJOMDmLlAqwfl6QXBYFJkEndz LQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa5kj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 20:00:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KJ8EIR032890;
        Tue, 20 Jun 2023 20:00:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93962r82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 20:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/kUHhAB66EVOteVYW/ereggGv2ProOgWRMfY7LxydM8XQtAdi7F1bgeSern59d0a/EiNNS00eA4Ap5FcsrkMJ10ujQQ11GjMY+wsMPOStljbLyaRoR6/aJvQ2TD5IDOBandNg3hsawlsp381iRiX/AKY6AfCMuLR9ldVsQFlJDfXy9CDM1Ov07ZY1Q2UdWWw3WoWIdNQjI48XrsArBfV8KVxbsXe5k5Wl+v45x2HkasCn2yLPV2RsGZMglSbVCpvLwWMAkyyUXXo2qUMDq9F9E+Z9afY2dPlHItX6d92gx8z2j+boUn2xpwhHa2p27hLl1oJBkm9N9rvx2h1n7uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSc17VmV/HzpUHi1b1dq7oVU+9aGcasJLDG4dMbEVzE=;
 b=E6vPZcpaUDZXdwNTtuxwQZk8VPqzyi00Q39KSi9t8arfbELSpizA23Z3hHkspSxCgOwD34FUSwmrgdN/mqEzwAeGxHYc7atAa07xoRstprUzEQui+O/UzwIDRCzVCQhHLO/WdlMR3QdZHGCKN0IHS9+vshopgJA46W2TAgqRWfnRDsX2Z/TPA/yChSY3wl2Td00V7Mcvk1DaVUteSfulzCIdgiRLv5prLtSNBdBAjWI/c+gdbJIcTES5Bdiq4PhE3UG0fPfy7eUM0TWzvLCR0N7QSZz+2iGhbX9QxbcOpVlP/U1YWhMNTsLIg6VNR/PrpBBXCHWNrFf0Aj6uSv5pMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSc17VmV/HzpUHi1b1dq7oVU+9aGcasJLDG4dMbEVzE=;
 b=VBK8xh+7xsedaGynsKAMYTMnYLrhcvg/GwiAAb0HmEmNVfrAhe3p8o9n92KxS4F57zr4P4Xetzc2XdMsWlnSRHcuWfueltudK/DRUCsP3pDpW9gRP1Dg/tg8J/n4BKvhx6K6JqZbGKX/RqGSScr2fd8cYDWXCIkxN12qwESkwt8=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BL3PR10MB6137.namprd10.prod.outlook.com (2603:10b6:208:3b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:00:02 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:00:02 +0000
Message-ID: <f2db4a54-3223-0748-b855-2fbe80008dbe@oracle.com>
Date:   Tue, 20 Jun 2023 15:00:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] fs: jfs: (trivial) Fix typo in dbInitTree function
Content-Language: en-US
To:     Wonguk Lee <wonguk.lee1023@gmail.com>, shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <ZFUNHFUr/IhyvTn9@ubuntu22-virtual-machine.localdomain>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ZFUNHFUr/IhyvTn9@ubuntu22-virtual-machine.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::8) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BL3PR10MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b9e88f-bd2a-43af-e670-08db71c8ef25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ob+9vpH/Qnt7ib+w2TFNH19103uuLIlBZBCj4ui/Qvh0b3JE/ljszIyZVNVEOGkvVNAXkfPAyHVOY5zzdBZtCiERzjCcq9KYX+fICqr/vERy8F5F1odVJUrEscTOaegk96iWkXBxgG/WCIrwEb78IZY1Zn2ab7uRxJQ9zrrFwv5K6O19gDR6j8GbZOT23EshX9yLPFdLIvozmI0ZBQy5evXqUDbGfPD+4SdYq1AX2zFeDNCEkVwMjLSRki7PPU5ngEfW8v3jBYZwtbwW+V3oDzlBH4HdOjOi0jjuVG1EVrhJsIePqyvNMv8694pa7Ak7ZPdeQIlh564hfZ/w9d6axRMZyxclsWjTYHoYUDW4WVP1mOs+fJDeWFlttHrSD5Y2RVS7avdhuA7l2d4mSUIqU3a2b7ulVYfkGdzpsWo4G3kowKREJv6NNtTa3hC2fcLDZPY8sWwk79U+JsLCr61BIpVkvgGdf/PnoTblWlLqzbySi9mDv+MdI86igJhu9/lWl+mC2ZfK60cGcJk3I/MIGy43IArs0JfoCet8Xajb3r/apzuOHEnzVrdy+KNUPklZpdo/Y8aQw9shiFDlgFISGz72QaDtXX8jEPjjgbgbNPCkrQK+pUXXZvT5+8lP0mcKt6hXzIGubbZHGOWWmhFQrxMpIgdoQqhUeIeGzU4jufg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(6486002)(478600001)(186003)(83380400001)(6512007)(6506007)(26005)(2616005)(38100700002)(36756003)(86362001)(31696002)(2906002)(8936002)(8676002)(5660300002)(31686004)(316002)(4326008)(66476007)(66556008)(41300700001)(66946007)(44832011)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUo0RkxkaGpIUkJuRWV2Z1ExNGJXTVZrb2dMTzVWRWdzc3VrV2wxbklNZkhI?=
 =?utf-8?B?eDZoM3p0NXU4UzNXVk90ZmppcjRabU91b3RURWNrQ3dJNlh3V1l5WENmZXpR?=
 =?utf-8?B?bnBXKzBueFVDeGVRYmlBZnk2Qm16bER0T2ZvU1FnWmM1TWwrZ20vZElNYzlF?=
 =?utf-8?B?WUYxZmwxN25oeTNJVmI2WFpGeE9vNDBqT0NmdS84dG04U2VETUsrK1FSazJZ?=
 =?utf-8?B?elJNTTJlVjBVVm4wdElac2FyOUYxdWFxcGRydEh4SlNLU0J0eW5vSTUzeVBJ?=
 =?utf-8?B?dGNxc2ora3krTDIrcHZTeFpEZW1rN0pzNjgyMnkwVU5HeXhQL2hiOGgrNzdS?=
 =?utf-8?B?cmh3SjFlLzJWQ2lnaHRUdWcrTExsSytBOStiaWN1NSs1bGhoK0VKQVpiTjFR?=
 =?utf-8?B?U3ozc0lHVGoyTUI0TU9ud0R6VEJoVm9lNGpES2VFbGFDTkhGVmF0a2FOS3Nt?=
 =?utf-8?B?Vkg0ZW9yM3FMbWdjaWhKTnM5TnJRZTZjR0s0VStVU085U2ZiYlRodUN3SVBX?=
 =?utf-8?B?RGc4NXZqU2o3ME9hU0ZQeWgzUjY3a1MrcERJckYvMkN3NW5XTm1ZcGhUcUZ6?=
 =?utf-8?B?TXkxc2lUU25id0tPVzZIUDJlM0hpdjZPaEl3dnZXd0dBVE9vTDFaUzdwbzFP?=
 =?utf-8?B?UUpqRlUwQXFHK0pNYVA1dDZWZzlqRzNWdzEyY0JSYnd0eGs0THlrMjV1bFdn?=
 =?utf-8?B?dDIzeVpiN3g2KzgzenhiNS8rTjdLN29ob2Y5Q2dSU0c0Z1BWNXFzYnUxdmRI?=
 =?utf-8?B?YWVCakpET29Sc3BnWHNGWmJNcHZhZ215b0VjSU9WQVZyYmIwRm9neEM4NWVX?=
 =?utf-8?B?dW05aWo2TWVJcXJZb2ZPR1Z2enduSXYydXNKMmhZa0lFaFhmZjJESXAvMHhB?=
 =?utf-8?B?TVFOalpDM095dEVkakE5SFEyMHdYa1RZdXc0WWd1Q3lnNDNtWFIyWXZKVDYv?=
 =?utf-8?B?bHRJKzlTZEQ0ZUpBc3E1M0tmQ2tmVmdaRWhXU3doWFJadWpOd0hZWFM0TkZJ?=
 =?utf-8?B?cElMRm1ENDVKT2xybUNwQmhQS2x0KzVSVXQ1OG9oVktueHV3UHBHZDdQUDlq?=
 =?utf-8?B?UTlDaUtpT2p6OStXSW4vTlBndVNMdWJUWW54VENqVlpRUXJhUGNLZ1B5bWNL?=
 =?utf-8?B?L2R3aFltUlFML0ViZVdhSFFCZDBsSC9ERHhGQkNEMlZIQUlqMWF1UlRuYnhY?=
 =?utf-8?B?NG5mZ2U2aWtoVEdja21JTE56R2NFVklmSkYxMXpCbjNyRFBYemppMXh2VDZX?=
 =?utf-8?B?dnBtSGY4MjM5NkszYVlZa3FIRmR6WGFHTzVIeGJPeWhQNEUwajVRYmNhakQz?=
 =?utf-8?B?emh1QU5OZ2ZHaVZhU1ZDdnJMQzNDdmxkMElIMGFpV09YOWk3enBVb1d5TlEr?=
 =?utf-8?B?ODlvdmxXYjRHaUpVeWVvbVRNaEhmWDJLSDcySG1XUjNLWHh6LzBsZU5VTGJr?=
 =?utf-8?B?N2xYSVRQdDF1dlUxQjJVVWR0cGlsL3IrT29DbHpHYmMwaTNZc1ZIYW9GYk5K?=
 =?utf-8?B?VkdOeXlPUDFlVVZ3SktkdFo3NWFWUkxwYUdJTmU1N2pDaDBLaGFWSFdXc0pk?=
 =?utf-8?B?NE1KN2FGZXVPejJHTVVST0llTElMRnZBK2RXNGJnTWtEbGh6NnVHSSt5SkN3?=
 =?utf-8?B?RUtkdE5lbkhlNWJ4ekx0b2I2YjYrdXZ0Z2d1WXVLU1VPd1ZFZm0yUGFKZ29E?=
 =?utf-8?B?YUc0ZFM4eG40eUxudm9oWDlQRGZHWFRYMjBjLzFNVi81TFVrSERkT1Bzam5n?=
 =?utf-8?B?aDU2T2RFK2RzZm12Mi9CR0xHcHRaeEtqRHgvSFQ5N09ENjN0ZGcxU3ViTXdB?=
 =?utf-8?B?bjNDeTl4VG9Kald4NjJDeHVBNDZrY2hTZnhHL3k5OUEzU3ZpcmpFdDdITFJa?=
 =?utf-8?B?UGs3cDZoS2VtYmR1L0V5RDdwa1o0RFAwTnB2QnkwSTAvdmpDOGU2ekpiYXli?=
 =?utf-8?B?blJteHd5dkZjRnZDWnptd2EwQStBQkFtNzhvMWxJUkxUajYydHdnM3ZJWkdh?=
 =?utf-8?B?aHVEOVJ0Y2l5NTFCa0F2N0dEYjVUV2dBYlg1OFh2dzlCV3FtaUtkMDl5bDdT?=
 =?utf-8?B?cnlBM0FNZGNOVWJscFk2YkZpVmtINFhmQXVzOUgxaHdvaHU2QXJtd2l0TDVn?=
 =?utf-8?B?YnpMV1JNNDQrWlROeEJBaitsNTBNeXBWeDJVcVFzbGdNNnFuVDBiSVN2UW5w?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z0ZKMUh1VHJUTFdiRzBYMWMzTjIrcEk2d1BwbHJlM2NhZTN0TW90cjhSa00y?=
 =?utf-8?B?RHU0ak5PZ3J6MXVmVldrdng3OU5UZUpnUE1Bb096K1RuRlBMdmtKWkJ6cWVa?=
 =?utf-8?B?cDVVeFd5MGQ3cHU4eFFibkFkNHNqNW1lUWltTjdIS210WFFqU0JVa1dxQmFF?=
 =?utf-8?B?RnNhbldyVWRrYVB5ZmxheDUrK0tGQTh0MVpSUzRvOHlHYjdkZkFpVjEvSUhL?=
 =?utf-8?B?SDhjVzBnUFh4Wlo3aW9WKzc2Qnk1RGJFL1FLMmI3dG1zR3E3TEFwdkgvNWhN?=
 =?utf-8?B?VjVjVVZoeVAxWnc5UDVjZHdEN2QrcGpOK0J5QjBuNVdtYm5hN0dxTVNPWExs?=
 =?utf-8?B?ZmsrOEJTNzJhVW9VWUMxaVd2d0hFSVRSN3RQK2ZacnVPbkZSV3lsWlFIejRC?=
 =?utf-8?B?dGtINlhkdTVhcDl6QjN3dkhJaFRWdE1CZzJBS2lwVGp0QldSRERRMVJldjV0?=
 =?utf-8?B?a09SOVl3b2JxaEFMOFdNREJIQi9RaU1VN3FoNUNmRXJ1YTk1dXZiaXVQbitx?=
 =?utf-8?B?eVF6V1hqWFFCMnpFd0NpVTIybGVqdUppV2lVUkh6Y2U5bng2WUtGL0VyUVpq?=
 =?utf-8?B?K3c4NXZkVkd1a3NmaTV5UHNINDl3MEFzeE5McGNhdzA1bys2LzJqaGVZTzRr?=
 =?utf-8?B?cHdhMmlDRjBrdTZ3RFVPUmhRbFFWMHdyNWhYTHg1OTIrMVc2QmtubjJQdFJ0?=
 =?utf-8?B?V0tuM05mN1NMR3pnNjBqbGdaUnV5WUZja1FOZUo3dW5rY0pkcE45QldjMm5x?=
 =?utf-8?B?YVJIWHQzS01nczR6UWFXakRvWHpsNXo0cHJBdlhScXVNWWkwamVwYTlyZWNY?=
 =?utf-8?B?dGpzanFOdEtNTHBXQ2IyOUtrSWRMQVduMmEyN0xMVkFLTCtpUkp6a2pJZlVU?=
 =?utf-8?B?am5YZDA5alp6OU5VanFtZkVSblJlK2p2VEp6ck94WVZXOU5kVWdaTWhhN0Z2?=
 =?utf-8?B?ZWpyQlpxa05MM0ZCVmlJZjBmV3VvQkxnZ05vSE5hRWNQeVlxSERoUHVValpP?=
 =?utf-8?B?V1pDVXA2RHhlTHVwb2E5M0hBUzNuTmlJUWVOQkJISWpwVTZTSktKbFJoU3NE?=
 =?utf-8?B?SDRwRjM4STNnbGp0c29hK1M4U093ZHJwb1l0T1g5NDBmSGRvMGdKeEF3bG91?=
 =?utf-8?B?akRtbFhGU2tIQWQwU3N6b09FaTlRb09wQTJYWDA3bG5zN2RVNjhZdVhEaUpn?=
 =?utf-8?B?b2lHNVh4NjN5RStOWW00OHlQQVFQenFTLzl1aCt2YjN6c3RKNExKOVhLVjhn?=
 =?utf-8?Q?1zXFPFmKaKsly8T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b9e88f-bd2a-43af-e670-08db71c8ef25
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:00:02.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWDzmQlP6FDaYOZUxhHqnQdv3cSyNJyQ3Ol1DwuiJlQHqKldvmBh42os9ooAREL2XU4pnYn0EGhBH6tR4jEoLbuMGbubivNbDZqGgtWHZQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_15,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200180
X-Proofpoint-GUID: VtpC3cCit4kj81GKRbcjDojGLUBsNymH
X-Proofpoint-ORIG-GUID: VtpC3cCit4kj81GKRbcjDojGLUBsNymH
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

On 5/5/23 9:05AM, Wonguk Lee wrote:
> While trying to fix the jfs UBSAN problem reported in syzkaller,
> (https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2)
> 
> I found the typo in the comment of dbInitTree function and fix it.

Thanks. Applied to jfs-next.

> 
> Signed-off-by: Wonguk Lee <wonguk.lee1023@gmail.com>
> ---
> Changes in v2:
>    - Add the patch description and change the name in the Signed-off-by
> 
>   fs/jfs/jfs_dmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a3eb1e826947..d8a03d3026cc 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -3851,7 +3851,7 @@ static int dbInitTree(struct dmaptree * dtp)
>   	l2max = le32_to_cpu(dtp->l2nleafs) + dtp->budmin;
>   
>   	/*
> -	 * configure the leaf levevl into binary buddy system
> +	 * configure the leaf level into binary buddy system
>   	 *
>   	 * Try to combine buddies starting with a buddy size of 1
>   	 * (i.e. two leaves). At a buddy size of 1 two buddy leaves
