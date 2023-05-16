Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196D70546D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjEPQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjEPQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:58:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EEB7EE1;
        Tue, 16 May 2023 09:58:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GG4cfA009625;
        Tue, 16 May 2023 16:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=pY/jgKi5WLsxoqyxlSfjeQrlj+5BQa+TecVjayMpLe8=;
 b=1QYSlwrQl9T98C/q3r+2i89Eqo/t5WTDWgIWYcuYwuAYHBwRohStDesyTSsZJm0m0Akz
 HjjIzq8js1aT7U9P+wMUQAp9pKs3FHiVkysn3El0goZ19L3VhBhXyz9cJPHpv+8CHbUV
 W3zJu2TiWrSmF3xvYksUc2UkVJhFcdqSTmmQXXSs54G27pq0yZrX2uuEHvmLMeuwSRAl
 49kLqgu8GXAfNokul/Qs7jal3OqW6QspfQ8CgFL/JVCEhrXPQJ8xeZwB2flMiruxnZWm
 avKq1V2dp4YfbUirQWGT5+BE7fi8Nb+HBea0eGtVAWBzfod55fyhwV9bM0CiMi+gQfsV HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1523n0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:58:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GGu42N023724;
        Tue, 16 May 2023 16:58:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10akua8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oABVJ2sy81Cb9H+6bzZ7odLtvrPjX6/l8gIxRL9MPkNx7AZoMGeUIPYIXqvCu/wtG94XlyiHL1pXdl+lPYH8uBQ0D67a9K149pDEg0gECpgDkrMIv5ImBhlqKhSRQ8hLbXbYOhfUAP7FZ9u2Rgy6iO4hCizbqm46kc70U3a/s7HRmNYyfMQ58JVeI2vmX6T3MWB9k6S0dLbx72omrlURye2GOO0jSVrxaog8rWjDFGxinz1r6XBbKk3e5Kl0U/KjcvVKuSvQS+jLjqqZUQoZkV8/yfYZp3oQ6ISCSIfTpZbtuIZLJkU3O2qgIEzNbfauNNg7u/Q9KB3r9KkDXDefvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY/jgKi5WLsxoqyxlSfjeQrlj+5BQa+TecVjayMpLe8=;
 b=dnb8tvjU5ZflYPl9qKDraeK2dzSo25nrB8Fj1XyTB3tEygYhONKQ9FF06wYJJLr7W9veqsTZSZ033/rgwLG01KwGx8TzivJa21eS3ewx5fMInDKUefoK/+6DPCZoW7XckETXV6wSurRU/EZG3yi5FaJmNKzBFyb+Eiv6yDT6OdBo4znw8AKvrV2XMkuG0pWKHnJnrWX0JdXpkdRdftQ6WfXHR2ZPd2xs/ODU5eFNVJ2pCsyEuOhEtiAyayDxiSRmVb9BwujCtmr076DNJW4Ld6HbmpinLzxHhENnK4mQ6Ah+lvywFIv1jgNNhYky3w1Cz4g8QgN5P0kE/KbuZVCxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY/jgKi5WLsxoqyxlSfjeQrlj+5BQa+TecVjayMpLe8=;
 b=aMep65CihR9Oo9CLJHgQ3dVj02FOw9d/TT37FRLqCZ0P4wV7gKKkM7PQ/97fMCUWd8wExM7cEoWxbbtNVditOYVj28NUl7nINGeMLZxgy1HmYklohbv6JGw3n4mvNoHpgw47sN/aR5+gbPbQed23FZq7aocEdZaz11QBvFUMxA0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6313.namprd10.prod.outlook.com (2603:10b6:510:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Tue, 16 May
 2023 16:57:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:57:57 +0000
Date:   Tue, 16 May 2023 12:57:54 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        lstoakes@gmail.com, zhangpeng.00@bytedance.com
Subject: Re: mprotect outbound check.
Message-ID: <20230516165754.pocx4kaagn3yyw3r@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, Jeff Xu <jeffxu@chromium.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>, lstoakes@gmail.com,
        zhangpeng.00@bytedance.com
References: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
 <CABi2SkUfsOWKGdFqgXZg=0AcnUj=AOFb9JmYfp=RwDp_5AcH0Q@mail.gmail.com>
 <ZGOworXBstm+jmw3@x1n>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZGOworXBstm+jmw3@x1n>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0278.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH8PR10MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce41290-f552-4a71-3109-08db562eb329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JYCfvzORn9lz41JRFgq0lB0t6qnkWWuy26dzAOJNqc+Cs+gairQwj7xspqThiLv81ieCaPvTTeN+VLDBR1ojAnMZU+vOVvI+qNBN6okAfJtLh0kIssvtl5+g1hEjASknM2faQanwTmNgIiiHMkGSw+eCi195ZeFYQ/a+EfCjqUsnRbrDCFFGE+LnYL1So5HcXPEwXnHdnHSpzl1ilnD2Ew4Ar11CbVpoAusKjO0/atMvc0luJ5Mwe+HlCAPdCVbkRXs0xtbJE1Owco4g/pNND9+tAQVEfI7d5WP00CX6zbL3gjddIuoPYtrqQV7BOwQroI8hOoEYlcuOm7wTZD0DcPxrcnlLDrB48D4UwQJ54HxL+YIWcEXpVu4WBzsTa5tplEHFVraYRCBxrkpJeTgxOYThlR7OGVTq3YdMUEHCjhqUYapsi5yV5uFSnqcQxq0YQgMJrhC0nmm7NO50fEk3NfPSrLj1tsXYlhv0DAjEuYyu4hkrGwbpWgYBFTzANUnRy9w1h2Hbo2x05J01fPJH70HSpUZQM+ljhlHAlrLM4IPjSyJiap5gP22UdO731gU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(38100700002)(33716001)(86362001)(7116003)(5660300002)(8936002)(8676002)(1076003)(6512007)(6506007)(53546011)(26005)(2906002)(9686003)(66556008)(66476007)(54906003)(41300700001)(6666004)(186003)(4326008)(316002)(6916009)(66946007)(478600001)(6486002)(3480700007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S094UTR1SnE0OXM3NFZBaUpVYlJXZlF2dUV5NjRsbjBTUkdHdmg1VEUwcG1I?=
 =?utf-8?B?RFRRVFlUU2dnTFlHanY5WjFXOEZSNWJZRHJoWFpaWmlZd0pGdTE5eDE3MWla?=
 =?utf-8?B?SEJQTmljQzNFbmlUaEhyZ0ppWURESXZyWjhWOHZFZnJYQmUzbnh3aHBjcm1n?=
 =?utf-8?B?ZWJaL3VQZ3QxRW9Ba3V4WHM3OHlZaklVQXZJQ01vRzFwSjRpRm1CUGJ3ZURS?=
 =?utf-8?B?RHFqUXg1L2ZHNlV0Z3Q2RFRjS2dSN09RbmFBZ05wTXB0TG1KV0VLdnp0U1lW?=
 =?utf-8?B?S2VLaEZXRHlOYXRKY0xqZy9qajJWb0lVNko4RlhEMGg0N1VhbkxUQUlBbDNn?=
 =?utf-8?B?YTA3SDhXYU5IdE5uTjJFNXh4M095VGJIUzZ0UTB6VVhZSi9aTEZzREJlUEt6?=
 =?utf-8?B?by8zOUZLL3JQdm01NFhEUGFRdzZXaEl6SndqZURqakFaaE12TWNDM3BaZHoz?=
 =?utf-8?B?SnRrdmQra0pIS0p3ZndGQjRUdityck9XbTFNd2lhSFlTMEJDVGZWZ016UUsy?=
 =?utf-8?B?NDBXeUF3WmFRN3FPeVVZRWtQT3JGWjFqVUhScXc3Uk02cWxQRDhkWG1WUjU4?=
 =?utf-8?B?VENScVpxWVNiZFpseEc4cWZwMXBZaGlRVjE4aHd6YnBFd21kTS8vQjgvNjNY?=
 =?utf-8?B?YTFaNjRXbkJjRkNKVlFnV1pDenkrMTB1WktudDlzanB0TTdMR25qV3doNWd2?=
 =?utf-8?B?T1dKVmxSTlk5cUJkVjlUTHBKMVNBcmRPQURMdGt3a21BNTJySkpadUpkbWJR?=
 =?utf-8?B?U0hUUkg2VTFKNFhSZG9QNzZqS2h2c0pUa1lGOU1xVDJNQUtvcnBnVzFKbUxE?=
 =?utf-8?B?eExGbFJTNytQL2RrU3BUR2IzNmFjdUxlcDBQQ29pZWluMlRQYnFjTUQ5RzV0?=
 =?utf-8?B?YUFqSGtYMHVaVCtTQ21ZRVQ1ZFZhMnJQSEhCcTFSdHZBaGdJbzhsb013aTln?=
 =?utf-8?B?TmF3VmdEbU5FK1VhcEEvQ0lpYXRNYWU1Q2dQRXdXd3VSaG0xY0R5ZXF3dzdt?=
 =?utf-8?B?RFNyTnhGaTgwZVdVaHFjZ2MxNVVjNWl6OGtLQVV5SkkrQWE1cllZajhaN1Zt?=
 =?utf-8?B?UGZjWVlZZGRRNkZlVEdZQncyL0pSSW5xd3B6YUIyU29DeGxORWFIOHhKRERM?=
 =?utf-8?B?aGlqVnR4RGszQXNKZWxtNm1RWUlsZnBrU0twdEpNSVdwSVJNaTJBbFVLb1d5?=
 =?utf-8?B?anhmR2NGOFdGcWlSYmU5N3lPUWdlQzdvazhTNElwNXF6Y1RRR1Z4eGlYbkgx?=
 =?utf-8?B?SHRkRVdXK3UwSzluMjJtL25JNmlsaFJPeXFnbHhnTXZIdDc3Q0cyVnpSS28w?=
 =?utf-8?B?STZBd241VDlacTZsaTdWcmc3QTcyTTBidDlsckcvcXlXRllpS2Z6TUdqb0pZ?=
 =?utf-8?B?ZEhyR1RZTUxYV2lHam5qWGlDeDIyc01HRks1dDhlTHgzbEx6OFhSUFp3bkhY?=
 =?utf-8?B?bjVNVzZZbDRaM0Yxc3I4TmpoWjUwc2Q0VzdyWktlWmVrNi9VTE1TWnpxQngx?=
 =?utf-8?B?Ulg2U0Z0NjZacjZEeWVLbWJKZm42TU5xTS9MWTIxQmdxbVptTHFMa3g3aEpT?=
 =?utf-8?B?cFRTK005MUZ6Tm5mc3BhV2gxT29Benl2a2crZWxIMm1OcmVIYlE3WFJxaEpx?=
 =?utf-8?B?bXZ5aFFoVGR3UzYveHVOcGs4cHZnbWF4RGpWVmhkZ3p3RjAyRjJZSHN3cVln?=
 =?utf-8?B?U3RHVHIyUHZ5amtwcmpzWkhtWnlQR20xOEQrL05FQk9vUVpEQmZBTHB2MzVn?=
 =?utf-8?B?ZDk1Z1RYZlRNNUhLSi84Y3VBUGpyWGxzNmM3TEJrdnZSUnBhdFROZndyUjhv?=
 =?utf-8?B?ZXFaVjgrbzNUbFJMb3dDcjBiRjEvSWNjUFVVazhLUGhhclhwU0RtVXJXODFl?=
 =?utf-8?B?U1JJME0rNmw1VFZhaDMyV3h2Yis1RUw0RnpHTm5zblRhVXFrak9seGdXc2JN?=
 =?utf-8?B?UWNSeE9nRzhDY1dLcmhxZkl1c3hMS1hNZWdiaDRvR1JFeVhtVFRHN1pZNVJi?=
 =?utf-8?B?cURwL21jTUJjYWZ4cFgrQ3ROd1ZVS1Iwc2ZPWjdvNlNoQkJORmhvSmVSelh5?=
 =?utf-8?B?NjlGV09VOWJ1RTJUYm4ydmFaMTBwTlNWa0w0ZVFPV2xnUFlEYk42MUtkTith?=
 =?utf-8?B?YklVUVBlVmZ6MDJJd1QyY0Y1eU1QdXlXVGZKOXV4dnA3WVFMTG91OHFrcGlS?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MUIvQWE2bE1xOTNSRjU3SjJmb21SQWFEMXN0a29zVHZFaWxwTE5xbERESDVO?=
 =?utf-8?B?bmQ2alYzVW1TNXgvYThnWVExUjdRY0hxZTlHd2drdVB4aFYzWVJwRWVOU24w?=
 =?utf-8?B?WnRuTDBHUW5KUlc5UFVxclNyS3RDM3hUZ1pyZVFZbytrV3FrcTE5NVFzc1Jn?=
 =?utf-8?B?L2N5WmdmY2ovZTgyNDdDaDd3Q2dNWEVHK2ZMSHhUV0YwTk1ZcS9sSGQzNEsx?=
 =?utf-8?B?ZGswc1JuSENmbEtOUjlHVTNrRGtVSGhtL1NqbFNLWStkQllvUitIRW5FR0VZ?=
 =?utf-8?B?Q3pQUTBCYkRGV3ZZVW8weTlQb1ROODVSVzNKQXF4amFzNjFJSXBTOWhKaFlK?=
 =?utf-8?B?SmhiNHFCTUhOTjBlcTRNTjRMcjNjdXp0MnNlV2JGd0JjT1Mzc1UzY0xaeUdV?=
 =?utf-8?B?MVNhVW5DWmtjc1h4bWdzL2JSQnQwR1dRWDcyVEhNdmZSQnk1L3g5NXhGZWE3?=
 =?utf-8?B?UkdUSnhoU0lHVDdQbFRUaG5WWUEyWmU3RWo3RUp6bkJRQW0zNy80QWNYaDAv?=
 =?utf-8?B?c2VYR2EvWG11cVdGMHpsL3VNQkx4NFgzZGV2TkRHc0x4K05ZdENNQ2dnSzdG?=
 =?utf-8?B?QzlYeDBOVXlQSEFhMStpQ1Z2cmZySXg5VWs0cTJSUjU5UTJYVm9RKzl0cGs0?=
 =?utf-8?B?YnBGRnQzdDJzT2ExNzhEazBNZXNRYlFaYkExS0lYVjZ3QzE3OGtFTjh1Uy91?=
 =?utf-8?B?WlJIMk1taWFMRkpiOGp1akluNVdKOVd4MDk2SGYrN1oxeUxLaGh3NDB4YXkx?=
 =?utf-8?B?TG8yZGFVOGhPdGJ0bGVOcmNrT3V5SWN5a2xRVXVEYXBRa0NiYTJTQmUxOVRs?=
 =?utf-8?B?OE9Id2VkNEsvR0tBdG9YVWh0QU1MRHNBQmtDU3hYK00wbjdmcXEveDlTNXZE?=
 =?utf-8?B?b2FoeTJlYUdub25oRmZva1RaWDBYeXd6YlhDTDFuQ3RTdGdYaEdyaHBaZDR3?=
 =?utf-8?B?RlQzbk9HMFFRVHd0Y090VjNVZUlwUXlUcHpaQ3kzRkFWeEt5YWNKaUR1Y2Y3?=
 =?utf-8?B?SXdmcUhsTHZEbEdiMUwrT3FPUlg3U2NEMnppYU9zbUlDU0NNNytkOFFKaXMx?=
 =?utf-8?B?V1Q2ZG9TSUpETTJBUGg2U3ZIYmprWDZWam9kMFMwemRjUkhVL0FTYXlMUGcr?=
 =?utf-8?B?S0JXR0gvV2pGbTA1L1N0Z2orQStna3JrdTZsTDZxTkxJamsraWF1U01Cd25T?=
 =?utf-8?B?R3R2L3V2NWIzZ3Y3MTQ4QStCdGFCSTZaa0JlTVp0ZS9zS3hvTlpUcituaE1n?=
 =?utf-8?B?NzduYkVXZHhaREhwOFVKS0Z5VXJ4SDZmWDZTZk9SeVpDd1Ridz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce41290-f552-4a71-3109-08db562eb329
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:57:57.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWWr4FdLqYyxCK80V/zd/DNxjtTsx2Ffq/irLl0R7PIvKf4fxFIS6YFdGe0B6TXxptDefrXF7iclFjLy50Yrjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_09,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=700 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160144
X-Proofpoint-GUID: mfhllBBJ8tDhINlsNoSEHdp-wI1xBNoo
X-Proofpoint-ORIG-GUID: mfhllBBJ8tDhINlsNoSEHdp-wI1xBNoo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230516 12:35]:
> On Mon, May 15, 2023 at 06:41:35PM -0700, Jeff Xu wrote:
> > + Peter, Lian, Lorenzo
> >=20
> > Is this related to this hotfix ?
> >       mm/mprotect: fix do_mprotect_pkey() return on error
>=20
> Doesn't look like to me, that seems to only avoid replacing an error with
> another error, rather than stop returning error for any case.
>=20
> AFAIU this shouldn't be intentional, but Liam could correct.  Maybe a
> bisection would show at least when it got changed?

I did not intentionally modify the return of mprotect for this case.  As
Peter said, that change shouldn't cause the change in behaviour you are
seeing.

A bisection would help narrow it down, as it could be changes to mm/mmap
vma_merge() and friends.

Thanks,
Liam

>=20
> >=20
> >=20
> > Thanks!
> >=20
> > -Jeff
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > On Mon, May 15, 2023 at 11:00=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> =
wrote:
> > >
> > > Noticed there is a slight change for mprotect between 6.1 and 6.4 RC1
> > >
> > > For example:
> > > Consider the case below:
> > > 1 mmap(0x5000000, PAGE_SIZE,  ...)
> > > 2 mprotect(0x5000000, PAGE_SIZE*4, ...)
> > >
> > > in 6.1 and before, 2 will fail, and in 6.4 RC1, it will pass.
> > >
> > > I know that munmap will accept out-of-bound cases like this (because
> > > memory is freed anyway).
> > >
> > > Is this change intentional ?
> > >
> > > Thanks!
> > > Best regards,
> > > -Jeff
> >=20
>=20
> --=20
> Peter Xu
>=20
>=20
