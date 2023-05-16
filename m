Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA0F704C36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjEPLV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjEPLVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:21:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913FA9;
        Tue, 16 May 2023 04:21:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G6TaRn027868;
        Tue, 16 May 2023 11:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1aGodFWI4njD9MTd2MBp19ie+T0wVW8SsCARtZSn+P4=;
 b=leptiE6aOH6+GlGyaFdD9L8gQGYJY4RY59zVYgdXQb4bzS3LAxHo9H3SIvCz+Qz45wq3
 BphkXV3WD7smRvYLM4Qgds96Kg+mJefkQEPWARXYZtd5CSNVJ8wIzfq+uF/WU/q/JIBk
 xCfjJbyDiF8d+nlfEeFXpjs42tgtqleavlaREfEsI6OxRLtn16ypGxbB7JmN3roqtEPp
 yTyPUROq/G/OPJaM3nBtK9orBnnFLd19L5BSHFB7MtUzdjVQBjNCHxFuav/IC14oLNxZ
 ZLzMLF82w2SMVcaRCEIdinjW7i/P5boraRHzNy0bGabdfXrdSGDRaU8ChvYsXRFcqAyj 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33utfrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:20:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GB4cKS038912;
        Tue, 16 May 2023 11:20:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109xcc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCX2Ae9Pf5hNnowMJh22hXndYvmb3kZxGtbh6vaWDDJOSmFQlPw3OpE7tbkMDa3ckc+X60QRSHGPn03G0UNHZcF0gd7TKMMAwOq0kyGo6XwSQhoDJ10huKMN8gYw4mCgKzA53xwtqFlb9BewmPyKLr0utEN0cxxQHegwUTHH9NELox1VDUpdpEY6JfT19oKdK0Qx/o9Kz/aN5J8PSnrRoxFtJTDYU2BWTv1OUSt/caapM4VjJ/IPkRER5Akk1LuerBOeBvIinwbAkAfREKpba8Kh6EtFkInC4p2az96ArsNPlJ3ae7BMpGdwryL9Lmpz2zQUhJd+Hch2mFIzTcdnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aGodFWI4njD9MTd2MBp19ie+T0wVW8SsCARtZSn+P4=;
 b=ZgzcOIK/WPMBP2OI+axj1LD2UNBOQtzaPY5Ev9pmEvJNWryfntxe0pmo2QfT83YuTWNQusmuwYoZhEfysJ6WbEa3N++KAizIqGRFXaRGklNeufXMsy+bZBUIHgGFLU3S476ZR+ch4ApQ7zxh7fViupZ7TnR20n3LCav6ymPJ8orpY7Ts9lKl8Wd1/QUZAS9nBnCEyLFmGAvjJp2zwJ4nE9LUU+wHHCoAxSyGbVwnIAVLDt5mT5+l6aV2D6P5Ok5IRgpTFTFF1yDhbcfgZHYFRkEqfOcuBk50Wb+tA7eba/4PXI0S5ZDcnoXANcZ5w0/vUQtz+eBnj4jcB99/ZXdmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aGodFWI4njD9MTd2MBp19ie+T0wVW8SsCARtZSn+P4=;
 b=Ii1Yo/yBuB0m396cEDskqD1SRJsJTGDYxpsoRwixxfgUmNjunqypWClBk8wVmDFCT2WkgkBsgMC3V5P3eLZwBKt7nZdYjObJGIiUunEJD3SaNd8cv9Ei7UOP2MmZguMs4vMNhYNPhyMNX8hsK2uPRIPVrjtLlV8iuHTfRHe+5Qk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB7027.namprd10.prod.outlook.com (2603:10b6:510:280::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 11:20:44 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 11:20:44 +0000
Message-ID: <7b9f6966-0c74-f317-b00c-8d32f59fe9ed@oracle.com>
Date:   Tue, 16 May 2023 16:50:30 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.4 000/282] 5.4.243-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230515161722.146344674@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 55436473-a73a-4d30-099d-08db55ff96da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Rjy5NhSzQoN6uq+HX9CjlOL/TL8gdl0Du5qfXI9CcSMJcSQd9I1ZsQawTKLbpDKUQV53AApVLBzvsbHuhoA+TSpI3ZXLUu9qFA8v+R0ORl+dWqCQWvIQ4tBHzkGRP5/K9Gk2tb/bqurO10SF8bBZrZ/YnP6qz2EJ3IJzvEkoT1LDfeQSPF6G+yhahz9hpOkYFrsh17UMXV+Zft0GhD/WaV91KnMXB2bqNFFKAJgQIH9mHBwBIGAla+En/Mtx55k4bVq3w8I1x9aNhXHjIv6zKFI1YT+QqOY/dfMxgxL7Xeryl07DG/sEFEiKc/AowJugBlvqxQJ3iVmAUx6LDpTlfUGYfwVFmF0leXxHkMwTHbaSQJJYsJBCNJxOwTHWVp83ZbSSxjgeVNbfplegDGiWJeXjFQIdbLwFrYVC0S7z+BzFzG2NkWCiYvKbpTEeZyAQV6YLRp558Ptd/niqC0cj3G2/j9XpEbl2/JIYN8pt8CQYKqHp4ew6tHMbmH/DNWcN7Eun0iQGo8iz2VXPLDM3UfQBpy99bnW/UD2bZPvi/u4u+zLSaOxFEINlUDb/ARwzyiSOYltmuoSdqANAAnlelt/eDFV8PvVHd59RSS7QIOtJlgd/mHRuj54nNDd91FgkpwzjOcd3bcwETg69zaSTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(36756003)(6486002)(54906003)(316002)(86362001)(66476007)(66946007)(66556008)(4326008)(966005)(478600001)(8936002)(5660300002)(8676002)(7416002)(6666004)(2906002)(4744005)(31696002)(38100700002)(2616005)(6506007)(186003)(107886003)(26005)(6512007)(53546011)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRHSFB0cjZnZGZhUUFYRjF2ME5mZWpWM1BLWWNXTlJaSTl1THBPNHFnbCtk?=
 =?utf-8?B?ZmExSGkvUWM5RlJMS3BoK2dEdUVyRG5ncWVHRDdFM2V0YzFsTnFrQk1mcmcr?=
 =?utf-8?B?UWxvTS9tTit0TVlnYitESXJDcXpvdSsvc2ljY0M1UVBKUDhrcU14WGVYM3Fp?=
 =?utf-8?B?eVZmbUtSRGlPNXZBV1pIQThUd0hLbFZ6ZHlwRHQ3VVNQaUIvOWFvTnI2ZkRD?=
 =?utf-8?B?N0JmOUZaYzY0cmNmNTE0aGRueWM1eVRqOVYrQklXSTJKM3ZWdjFiYXRDUFVF?=
 =?utf-8?B?ai9yMjkwclJUbkl4ckxmVlFUcnVSMnJId3lkRWxoZ1dTdkE4aDhUYzFnWDFH?=
 =?utf-8?B?N0dEVVFya09FUE0zZHVPdENFRmZNOFlMQ3JROHRYS2ZOZE5xNWdoTURsRjRp?=
 =?utf-8?B?ZXB3dzBlc1FEQWM1N1Q1TXJrU1VLdXBGamxJelJDa3B0bFpmOG1VN2dZNFlr?=
 =?utf-8?B?V0dhTW1nUWVRS0F5T2plNVJQVGlkRXFtWXVaVll0bUkrL3lOaWxKcmtvVmpV?=
 =?utf-8?B?UUs4MXg4b0lzWlBFa0RIT1NLZW5sZmlaRHZvaG5nSFdsMTZLOExaYUM1QXFE?=
 =?utf-8?B?ZktDVFduK0FxbWY5Y0V2UjNjTzMvNy85Nk4rOThGT1J0RzJWOUxmTUVOd0dp?=
 =?utf-8?B?dlM5aER1eXkwYWRZUkJoQ1lmYnlBZ3F6L3ZlNkEyS1BRVmZlK2JFNDVjNmVh?=
 =?utf-8?B?d2xjdjl4Uk9lNzIvNXpBb2xmMFZMc1E0dDhsRnVYa3B4T3ZzbXpsL3FOdEI4?=
 =?utf-8?B?MU5pbzlZeThWbHllaXY5d2dabFBOTm1oVENCQW04alRmUjM0anRjblJsdUJi?=
 =?utf-8?B?VHVDZERoeVNYYmZtUzJWR3hZV3dZYkc4dDlZZk1EMk91aDBnVjJhZVV6SHU1?=
 =?utf-8?B?ZWFkN3VrR0IzUkp2dWlHRGl1bG42L3RPQmM4RUxsZC9LdlR1SkhLMVU4R3NU?=
 =?utf-8?B?aEN0Y1FLWm1wcDBJUVdvMWdNYk1PYVBYWmhVMm1lU1B0d0YxSFN2dnN0Wk9Q?=
 =?utf-8?B?dG9PTUc3TytTZHc5U1Z4VnkxcnhyWVV1UUF3UHJQOXpCNWRxNEZYUGdyNS92?=
 =?utf-8?B?VTVvSG9LL1FKOW02dDVjTUVCRlFDTFk0RHhEVkNIN1UrN08xVS9EckNkeDZj?=
 =?utf-8?B?L2p2SzcxNFlsUno3Z0E3WFNPM2N5QUFNaFhzam5KNXoxeGFmU205Yk5KbW9N?=
 =?utf-8?B?R3JhRzVhdmliUnlCdEQ2Q3VoSWtJZ1poQmxmL2NMOW5CRG1jRmRoRTJ2N2Rl?=
 =?utf-8?B?bEtiaWVoTi90NWVualNEMGRjNTN5dGQ2TnVFNXpyQTJra1FCeUZQSGNvWWRj?=
 =?utf-8?B?U2thUXhVNXNZU2Nsbzd6ODduMStLOGZvc0laSnlnNzRueUZLYTUycDAzaGxy?=
 =?utf-8?B?R04wN1pRL1Q1ZllsZlVNYVMxeDRrY2lKZ3grOG5zdjRuRVlmSjJRb2JtMFBY?=
 =?utf-8?B?YWZxNUpnd0duU0kzVCs5cHRvZEVaTlJDaWFEdzNXZGFwbWJMMmdxaFNGQUNE?=
 =?utf-8?B?YitUOWZTZy92R0lZT21mY0xPYzdTb0hzZDEwK3ZQR0thcDVSVXF6U29vK1Ny?=
 =?utf-8?B?T1NsckpDK1kzalNPNG5Cc3lpWTNFMkZPV0ZWenFTRDZuTzdQQ1hPMW90anBk?=
 =?utf-8?B?UGRIWFE2S2NhcnpCd01pUFNZNG90QmRzZVE5QWtlbTlqM25aSFZNWEhWZFRU?=
 =?utf-8?B?QlU5ZWJoTVZTWHExbWV4bVA2UDdRalVjdnFXemZWc3h0RmF0TlFuM0JyMVlD?=
 =?utf-8?B?SlZETTdYOVQ2QitIcGNrM2NFWjRWY3dlSFdzOFdNckFwREI5dXhwemdqdG5J?=
 =?utf-8?B?MUNkU0l1Vmx4SFZnbUtuNWsrSkVERWI2U0NMOEdhTlBMTEpGeGR5ZHlxTloz?=
 =?utf-8?B?Tnp1RmYrRk0wMGJKQ3dGc1hWTmNOeDhVZS9GV21hdHQ1Y01mKzFSRlAvenk1?=
 =?utf-8?B?dlYwRWZ3S0ZsNjVUZGk5ZlNYZjF4WVJFNVU3ak1vZ0poanJET2taYUNBaW5D?=
 =?utf-8?B?cWlROU45aWZpbnRJWUFIRkhsckxTejJ2OGpiYllSQ1B2STVKaGxsWFozZUp2?=
 =?utf-8?B?bThEN1czRzAzVm1pZy9ReWM3SDVIanozMXczdmhtL1pMNUxHTEhxaWhDRUg4?=
 =?utf-8?B?QVpnajk5N2loSlQ4MEtocysvV3NKVU5rUUlXMlpWazNLTmRFckJ1NHZkeUR6?=
 =?utf-8?Q?eAQBL+yONO6Po7SIy0pBJtQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z2ZJNmRGUHpndFBRbzdGUHNGL1FWVUpsR0JqTEEzb2t2d2JTYnIvNTdGV3VS?=
 =?utf-8?B?M0NWdVl5SUtZRDJzVG5oMkMzVmlGMUhUQ2JNQnZWbXVEZVdYNzRKUDMyUjFr?=
 =?utf-8?B?dWlONHBQSHhUZzhwb3hHdysxYkFhdjUyaHBvSFYrdkZJYUV3c3BRc2dOdnky?=
 =?utf-8?B?YnJrQW4xMllkK0FReTNDcmJnZXk0NVlEUDV3KytRUUxaeW0xejNkOUw0VFkz?=
 =?utf-8?B?MEtXM2FpYzhONHJRYXZJSVlSL01ha01SeklwOUphVGhLa1p6NzZGb01JQ29Y?=
 =?utf-8?B?VE1JUVdUaUlXQ1hIMFRHL25zeVZZS1JON0x5QkEwSFcxdzlLY2VYSE5HRFR1?=
 =?utf-8?B?R205Z0Q0bDgrQXhpQXV1S3N6SVIrOCsyTTR6NFRIbTNvY1RTdFEzTFFJU1Qv?=
 =?utf-8?B?aEZrNHQyUG5OZlYzaUNZeWtONjZ2bk94b2VsaHZnUzBuMXB0WU1lb2p3NG9x?=
 =?utf-8?B?Myt5cWtvZDN3RktkTGlDVjhiQnlzY2VLSUJMenE3bGsxc094b0hUK3RFZDdB?=
 =?utf-8?B?azJjeDVXZ3RNdzViaFErekc5a2ZFQk00MXJOTjNuWnRUSW1JcXpTNlBwa1BD?=
 =?utf-8?B?cDhRdXZjVGJkelB2R2x4ZDlaaVZTcEJQSmwrUDBJN1JwNFUrOGJISUYyOU5z?=
 =?utf-8?B?aEI5MjB3N0UxUC9adnhKVG1xTUhrVkt0QXliZjhZSUpKQmlaMWhLMXNOYmUz?=
 =?utf-8?B?VkhSRmlCcjkyUUhReTdqeE8yS2FFcFZURWFPdE1lam9CdGNqcUZGcTJWVHZH?=
 =?utf-8?B?NmZRaU1LV0toRnM1UlVyUXFDcDRsMW1JcEVRU29kUCs0ZTNoTEFBbXExVUtK?=
 =?utf-8?B?U0pZTC9zd2lySUNhMUNNMHBHeVdNOVB6OXJUTm1wTE16NWdRM0ZuRSsrS3pm?=
 =?utf-8?B?ZC9RZDM1dzVMQzBROFoyaTJ6N1ZOdVVteGptcy9icEZLRjI5NnNyblg0SFg1?=
 =?utf-8?B?dW5KdkZoT0pWZGwxSFlPVjQ3Z2pvK2pLMWNpRWF1UUZWZEw0UzNHRnNvT3dC?=
 =?utf-8?B?ajRxdFZ1VkVwNngrbFcwU28yN0JWT0grT2UvVGxYZ2tkdXd6WFh1MmNxTWlq?=
 =?utf-8?B?TVFZcU14OTlmWXJ3cDJvRjIrZGpoVXhaRXpKQVp6MS9veTd3VXdlL0VBUW14?=
 =?utf-8?B?d2MycmZMdHJNVDJ3SXZEL0I4Q3cvMkpkKzlHRDhYb1JURVp3RW1sa3BJWFFC?=
 =?utf-8?B?ZFR5SlREUm9yV2pWKzQ5SXZJaWFYaThJVHNsZzd1NS9NZXR1ckhZdW5ERWhr?=
 =?utf-8?B?UUpNY2VvVkNvQi95RElVM2s1RUU3bFgwRHFHUzhocndLcnM5OEtMME15Yjlr?=
 =?utf-8?B?M1BYUnRnSlhjMzM1TkxJRjZGN3JUZHMvVGNmUVZmbVRoYkZlNGhaaHlNWW9p?=
 =?utf-8?B?Lys4d3dzK1YyM0ZvdWdRL0F1SEdydU5PdVVrWkJQM2ZrMEJSd0xwR0R2Y0cw?=
 =?utf-8?B?bExtQmlaN2pVRVNNbldzZ0ZpRGVNOGVTbkdZL0tpbFhIeXB0Uy8yQXVBMExX?=
 =?utf-8?B?WEJXVGpMbWV6cldZMmw1aC9Vdnp5bHVTa3RrQ3VEbFpiNlBrM3B3a3VnNXZP?=
 =?utf-8?Q?CdGg5XPtKKfZbk/QEN+XZ5h/8yJe2PwLcCiL5um8C4pZiR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55436473-a73a-4d30-099d-08db55ff96da
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 11:20:44.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEtUUs7klGTF+niTdtjK6VyWLINsLtCCznDq5k6iZeJoLiSKoKkzw7caBVEoCG/i4QrRslBEikhdUz6bTqQQf8vE0fcaKnPd1ErOTAiR6Mb3Nfq1iXkji7livZehblf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=998 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160096
X-Proofpoint-GUID: LPr1OXUJHSeNv4_QllQocQca7jo__Osv
X-Proofpoint-ORIG-GUID: LPr1OXUJHSeNv4_QllQocQca7jo__Osv
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 15/05/23 9:56 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.243 release.
> There are 282 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.243-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
