Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA07279F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjFHI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjFHI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:29:28 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FA26B8;
        Thu,  8 Jun 2023 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686212966;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=s5UfRwrxBGPQw1ksmHRPbDzehOZoq/nA1XECyphARXc=;
  b=V5LQ7zqfkU6hgtLFFypD2VAK0/pgPIhUUT3bJUmZ6H+SbK+GBHZbG5Ok
   2UboAI6DREr0WlZ3tARbD3kMj+e7RUQFIQKYMhuecoPeJjCIGiaUyD+EP
   N4bVS1DPRXYaeMmmtR6vtKjpM+7ad3B5oTReay5vgWmJ5xef7OQP1jAvp
   w=;
X-IronPort-RemoteIP: 104.47.66.46
X-IronPort-MID: 112448154
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Z8zlDq5iuQ+exh1tlXUKbAxRtHvHchMFZxGqfqrLsTDasY5as4F+v
 mQWCmuOMvyNYWHyLtEjb9u0pBlUsMDVztNjQVQ5riphHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35JwehBtC5gZlPa4T7AeH/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m2
 vVIIw4rfx+6qcGa4/GRQ9IxucUIM5y+VG8fkikIITDxK98DGMqGZpqQoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6NkkotjtABM/KMEjCObd9SkUuC4
 HrP4kzyAw0ANczZwj2Amp6prraWx3+nCNtPSNVU8NY3q02N+m0uMCQxckOkh+mahVTicelAf
 hl8Fi0G6PJaGFaQZtXwWhyQoXiavwUdUd5dD+077g6WzqPepQ2eAwAsRy5Lb9EOt8IsQzEuk
 FOK9/vgCj9HqrCZSXuBsLyTqFuaIi4UMX0PfwcHQBED7t2lp5s85jrDS5NvHbC4ivXvFD3wy
 izMpy87750WhNQO3r+2/njGhSytvZnDSgMp5gTRUXmh5wk/b4mgD6Ss6F7G/bNKKIGSTXGfs
 3Ue3cuT9uYDCdeKjiPlaOEMGqy5ovWIKjvRhXZxEJQ7sTeg4XiuecZX+j4WDFdkNIMIdCHkZ
 GfXuBhN/9lDMX2yd6h1bomtTcMwwsDd+c/NU/nVap9LfcJ3fQrepiV2PxbMgSbqjVQmlrw5N
 dGDa8GwAH0GCKNhij2rW+Ma1rxtzSc7rY/Oea3GI92c+eL2TBaopX0taTNisshRAHu4nTjo
IronPort-HdrOrdr: A9a23:G7onnapr57uthxW1nBDPqCAaV5rveYIsimQD101hICG9Evb0qy
 nOpoV/6faQslwssR4b9uxoVJPvfZq+z+8W3WByB9eftWDd0QPFEGgL1+DfKlbbak7DH4BmtJ
 uJc8JFeafN5VoRt7eG3OFveexQvOVu88qT9JjjJ28Gd3APV0n5hT0JcjpyFCdNNW57LKt8Lr
 WwzOxdqQGtfHwGB/7LfUXsD4D41rv2fIuNW29+OyIa
X-Talos-CUID: 9a23:y9pm8mHLSebgOpq8qmJI/R4fJOY0fUTz71vzYGWxMjtWSZaKHAo=
X-Talos-MUID: 9a23:AITs3goTuMz8zmb4LsEez2xJJNlU4pmWMWcqiYogq+qLL3BaACjI2Q==
X-IronPort-AV: E=Sophos;i="6.00,226,1681185600"; 
   d="scan'208";a="112448154"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2023 04:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkGvDoFLayPBVRfeOJn+r/SaFz3/A8QpeQzoL103hppbBfee/Oq9CH1nScaZJql6O69GRm1wFEMC6zk9rbyWHr4srUohXWwa4tVP8X+VhAdaSrc5wUlS7Z7qFDJAk5ojdOD4sOONdKyRjbF8n1EF0kKe5tkzemr+uKmyNOTgpUrUzEvjlWCRfpfmJ1O3oVeVHFMc8wS5GknBGTwwfdFn0oPq8f/NBKskjhIx+/CAmgfXQbvkonLjefjxqBFkpI+s2tneSd81hHuWzVLtsMgce+KAZKAd0U9MaeQEz5mwuVFYgnlw+8X7iboDa8Ri1oEUAOwR0Ds9njKqGFeIfeoL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umgdw07tohzefqm1klTgcXD7BeA8TvKMRB+InE5P3jg=;
 b=MVE8mbcVXYeBeRSccmnnm19EWiILjFW+kp1R0ktzakkIxBKYij3VtBEKXc9Q8vOHLtsuUwf7xJU50GdF9rFkt3l0m7K08tCP0janwr/d0C8gHdA/ZvD/AtZ6AmS186foYfx0cHC5ZEWK+9Q8oOT3I8TSUNMgpn3ix4KCQKcOFBQSlEhiq6T2figV3hpZc8OQkc/W7oKZVxeBVniZgnuR4ERicIJO5ueeRgd9j8nSaUnH2tfFzVVYpwtaZhXdMn8ikBnE4kmqOi5F6yhluvIx2W9ggwwm/+I+DPvGrSTpHp4MVtmrNf7I8w7PcPUVa4xA4AcQ0XdelghxCRCM3S1Pbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umgdw07tohzefqm1klTgcXD7BeA8TvKMRB+InE5P3jg=;
 b=JWbJtmC6urNxsU2yv/LcNd3AO9QSR0VtRHaGij94f3oOYcOiXeNpjzZXQzmgIZ6fKEshsY2rpRNpe5eWMl/KzsHSeTDegFFts+bYm7KAA4bkHzGSSX8dt50fqPOsxmVTCu2Gf73jI7aPw1HbxZ47tHbIxRKSICC6gUXQVtPh4Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by SJ0PR03MB7052.namprd03.prod.outlook.com (2603:10b6:a03:4e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 08:29:24 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd%3]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 08:29:24 +0000
Date:   Thu, 8 Jun 2023 10:29:18 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZIGRXrSGmgLF/07O@Air-de-Roger>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
 <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
 <ZICs+WYCPYdu2yoI@itl-email>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZICs+WYCPYdu2yoI@itl-email>
X-ClientProxiedBy: LO4P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::22) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|SJ0PR03MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afe84c0-0120-48bd-6361-08db67fa76e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TB6dm0wrZV9D3MSiBPmVQExFIRPMRGyECAvtMs3kaxuuCvmNWQ8zZtzAW3tkCHL19VqbRpSpKGNj8ShY70oSo8qWVrCmyaT2b9UflgBXvu97JCK+BOrncDejWWWZUZ8HQwf8GjuhMcX/0NG5M1pVQt94mU64wjSsElDw3CO1TLCIKuoazGh/hSySqTMmjH3Xb83N8/922d91+g4aaJoUI6ylkMPXZ/so12R8eWaA8ECZx+ZIQX1FaNNfjc0W0ZLsM0FDRizM8ErhneRU2jMGlQubOJ4yQqgqkJhE/+dbefcgu8RPFnARU77piYAZIXh/cqhEpsAgwMVlnmLdiZ5PydJ3wN8iIplxJUz97Qr+mgBka1Caqhwxd4AuJ9Np0n6yJecpif5FprpN6HV7hyaJFd01Wtgqwlwi4NssXjDFiB4F43Iwbqd23CBozZQZRiOLLZtB0kUuTewtysLFCT0pDh7KckTMnbZtvQM+Hlp3y3B9zZMf9H57hkqx72El/3vIPxHKRLkdqV0KtJ6+uXxBfmmFJ5Df08Ln5ODu5jrqHbocFDpcpPcdiahmlBUv/dWH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(66476007)(478600001)(66946007)(4326008)(6916009)(316002)(2906002)(8936002)(41300700001)(8676002)(5660300002)(54906003)(66556008)(6666004)(6486002)(6512007)(6506007)(26005)(9686003)(82960400001)(38100700002)(33716001)(83380400001)(186003)(85182001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxDUzJyZktLN2owa01HQjZCall5eGcvWjVzM1ZHWHhCVzFhMlZKUlJHRVBS?=
 =?utf-8?B?RUFzT1VwMkp5aWFrSWNBbDFIS3ZyOG85b250Q2t0aG5STENtcmREbUpPZlNL?=
 =?utf-8?B?WWpGMXJOdS9LeG5NMGpFbTNQNDNXUHhCWmkyR09XMUpXSUFCTXdoZzdjYlVo?=
 =?utf-8?B?T0JrUk1TVkE2ZDFJOVdLek1nbjZEYkZpeGZmZklsUVU3bXlzeFhaQzdWYU5w?=
 =?utf-8?B?a3dONzk5Nm51REd6aVhXMEkwSG1lK3NDUDZFNkZwZmIvV2VMYTliY1RTTW1B?=
 =?utf-8?B?UnR2U20yZTRzRi9IcnBMSGYrcGlUR1VXbzd1TSs3MnlpM21pa05XN2pqbUk2?=
 =?utf-8?B?VjllVkQrTTJtc3p3dXB0TFM1RU5zaVM3WEp5N29BTXpUUXp6NXE1N1ZtTmVQ?=
 =?utf-8?B?TEIxL2ZiSDVDS2lUTzAvTHp6MDQ1LzJDWUdHVmpYbkpEWlNMNm5wMnZXWHBC?=
 =?utf-8?B?d3FrQWdZNStjMzhtVnVuR1BTNWZabUI5amM3RGxLYjQveE93cFgwOEtjb01k?=
 =?utf-8?B?aVllZlVycDFzakwxVjhnT1J4UTNwcGl0YlpMT3huSHB3ZVQ2QnYwNkxqL3BY?=
 =?utf-8?B?OTRxbXlpM29KYWY5REQxUzBpQWRpMzRBTS9LdlFKZUxYd0VyWVdXVWpBYjBz?=
 =?utf-8?B?bmE0Sm42ZXBIUkpuYUlQd05FbkRTay9sUThEYjhKb2YrMVltdFZBaytOWWtm?=
 =?utf-8?B?UTcwVWNxUUdrY2s0ZENTeHhJdy9Paml0UFBKRVYzRWhEWkdMbnFRbW5xN0VW?=
 =?utf-8?B?TUQ1RjFOZjArNkpGNnZPTnJiY1NxUFlPdW04RDhJcklJTFNXTU8wWmVYVFNx?=
 =?utf-8?B?d3RqNHY2WXJhQklYa2dSTjBUM0RxVmpZWFZSUXU2dVRHSHpXRWtUeThlTWlU?=
 =?utf-8?B?aHlaYjdRdDBkMGdSbFAvYTRQdkhZemRwNWx2aWVmaElSOG12eGs5T0o5Ylhi?=
 =?utf-8?B?RHdudlFHTHdlVHc4NDRYZ1Fha0VVTXlQZW4zaGRmeVE1ajJQUWV2SnNleXlp?=
 =?utf-8?B?SVI0OUQ2dm5EanRBV2g4TEFBZjFsVnBvb3NCdlZnY3VLY2htcUFkNEhrQWpS?=
 =?utf-8?B?Q21lNXAwQUdaNEtHOEo3RzNKZys4aTBHRC9iQkQvVXJ1aGdrMDh2UWt4Y3BE?=
 =?utf-8?B?Z1VDODhIRG92YnZsWmxZRG9XOEtybDZYbkhic2sya1IweWhHNFhxVDlkK3dS?=
 =?utf-8?B?RnNQaVRsM3g1aGkxZlpmM0JtSFVvWGVycGVOSXA3V1gxeE1IRCtjNUpjUWJ6?=
 =?utf-8?B?bG5rTWQ0NXkxQnlkck1nV0UwQk9HaWhpU2NTMDdUTjFWK0lhbEsxM1I5K1NW?=
 =?utf-8?B?U1dhbnFlSS94VEVHWC9SOVVKM1N3MW4yRnNYbzlzQkdoaFYwQkhUY3IrT1pU?=
 =?utf-8?B?WVNCenBUU2EyUU1GNlpCWGxBblF0VjRjSWxxeXpNajlqbW5uN3ZhSHVPZEp0?=
 =?utf-8?B?ckNxM08ydFRvdzJLS09JaUlJVWJiMG9mVzUrWEYvWURidEJidlJqUHZpeWth?=
 =?utf-8?B?NlNhWEZXNDNrdmtlU2UwUTFRSDZEREpTY095aE90Y0pzSVVLbWxSYTR6SStF?=
 =?utf-8?B?eXg2MC9tSUFmSFBwbGZBVWt5QWR0alBXWm1wTjZnWGZwdGdJWDkvclE1UGZD?=
 =?utf-8?B?TExXWUdUMjdDdWJlK01VTzhURnFxdkFESXFrUXkvVWY4Ukg2WWFNQlNrdEZ6?=
 =?utf-8?B?SFV6SExac0lZWE9EQ1EzbVpxcmJKWnphdjNZTkJzUml2alBvbHA0eWJ1UHBZ?=
 =?utf-8?B?Z1dZekU0Mmg4QU1NQWliRDRlOGFCRUhELy9DTzVGUUh4TjluVjNBekxiK2M2?=
 =?utf-8?B?ZndPUkkvWFo1THZIdnY4dEZKdlk5bldZMDVmTHc0NFgyN1daK1phVjVqL2xh?=
 =?utf-8?B?U2JxZ09PaVJPRmJJS0U5TmFiQnppY3lqalBhTjhMaUJqN25kWFNCWXBsNVpG?=
 =?utf-8?B?bkNqd0QwWnhobGJ5V05na1hvN0RVSWd1OW5tcnEwUmN6RmdmNTdMeUg1TUlj?=
 =?utf-8?B?UHpDMHlYNmVVUGwxZnY3ak9PRnozTzlEYlIyUkpSMC9Db3FvVGpnMWNBME94?=
 =?utf-8?B?Q0RIRmM3b1dQMGJpUE0xNUovcHQ3NS9YNVhIYTRIaHJ0VFpIV0FoWXM4YVBr?=
 =?utf-8?B?UGY0enRGZk1Od3lFa2ZCdnlaUVhnOVJ1ZSs3d0oxZnd2WjZsZU5DSkFaTmRK?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VGdrNXNnS013WVRPVVJ3V1JtL2tnVXRzcUdRdHRqNWd3QkxUNnNlb0UwdGpO?=
 =?utf-8?B?MEh3QXU0SEQ1UkRrSzVISm5oakN2ZlBMZVlNTTU1ZjRtcmN3OGk5NndjQUxF?=
 =?utf-8?B?Nm5ueFZqU3B6L3NMTm92NTArOXBWNnpFdCt1UkhKcW1uRS9pU1NBWkVyODho?=
 =?utf-8?B?UnVIWFlwbzJQb0tteFJVUkJrQ3d0YVZhREJUREk5WjJlSS8zMnduK3hjcVNp?=
 =?utf-8?B?eVRZckxNY0V4UUJNR2llMFUvWUFFTlZ5UXlQZ0FjYUY5TUxGeStheStITmlZ?=
 =?utf-8?B?eWxPUXo4Tk1LZ0hJMFN2dkZWa2JxYlZsZk5jRlp2SVdLc1pQSGd6aFYxR2NR?=
 =?utf-8?B?Qk8rQmdNTzZybktjd2FnSHhFbXhIekxLNnY2bkRDbktRblpXcnJyU2p2R3NU?=
 =?utf-8?B?Rm5nZ2JrMDQwMk9XQ01YUzR2ditTZmduRDc3dzRKUnBxY24xdG9xK1E1MjZL?=
 =?utf-8?B?K3o5SFRlaTVFRVJIamhNNDZ6cGd2dElrT3hId3ZvZnBscG1CY2ZhRXQ4M0pv?=
 =?utf-8?B?VFpuSzRrbWJiU0lBRFVQRWtDUDNLNWt5VlN6RHpPTy9hN1N4ZEZRbWJFbXBr?=
 =?utf-8?B?VFVIUnRvaVpXTUE3aTlzNGQyRWxva3R2bGdHWWpWWjhnVG92N3lDK0p2TFUx?=
 =?utf-8?B?bnkxME1PRnQ1WXdxN2UwYndEZi9PeE83UUlpU21lWk40N3FKT1U0cjhWVkJj?=
 =?utf-8?B?dmk4ZzhRdlNBZ21pbEM4QW95MVZFZWdXTHcxZElOYXJqVXVqK2tvY1JVQzJ1?=
 =?utf-8?B?WW5FTXJBcWNUeG1PalhsQkpMUVRndlRnaE1OTkhmYjVqZW0vdmxKN2dtTDVw?=
 =?utf-8?B?MmxMaEtkaVFnc1B5TlptREFGSjEwR0h5bFR5T3dvb01OSkU1MWZ1Y1IxQmRn?=
 =?utf-8?B?VWNyYzg4cWFESHdTT1NBT2ZWK1pkNTcvd3h3MXIzN2pIcWpLUWZvTjNNVGFH?=
 =?utf-8?B?a3Z0MlFINUhhNm5nU3FBMWdvU3pqSEIzcXNNR2J2eENkSXJzU1czTlpVUC9D?=
 =?utf-8?B?aHRtUExCZ1pCZ0hTL3JCcTh4MHVJUDhUVE1yR0hveEtDVzVXTnY2RXRFYk9V?=
 =?utf-8?B?RjBWcmpvSjhmNThmVDJMWmhsYmhGQ0YxQURqWDRib0VKdTQwcE5lOC9LdHNz?=
 =?utf-8?B?TUhRU29tWitGUmo2NkpGQUtPY2o3NzBBd3JmT214Mit1eHhCa2JCT1ZsT1Z4?=
 =?utf-8?B?TitldmtXMFhndDJtcm5RbFpoQ0NvcTlnU1ZiTWlaeGpLL01oR3RSdHhBYThh?=
 =?utf-8?B?bkJnMGVmTWtOM0w3RXlhc2FwUG5GMkFkaUFGVVZwMnVNc0lFdz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afe84c0-0120-48bd-6361-08db67fa76e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 08:29:24.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ozwqg25F9uXKQWGwzS7CSPW5c7lRPHZdjCy0M7AxAUbwKBu47gSlG1HKfKkWZG4cqvWm+EVpemsrtaO+E6f1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7052
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:14:46PM -0400, Demi Marie Obenour wrote:
> On Wed, Jun 07, 2023 at 10:20:08AM +0200, Roger Pau Monné wrote:
> > On Tue, Jun 06, 2023 at 01:01:20PM -0400, Demi Marie Obenour wrote:
> > > On Tue, Jun 06, 2023 at 10:25:47AM +0200, Roger Pau Monné wrote:
> > > > On Tue, May 30, 2023 at 04:31:13PM -0400, Demi Marie Obenour wrote:
> > > > > -	if (be->major | be->minor) {
> > > > > -		if (be->major != major || be->minor != minor)
> > > > > -			pr_warn("changing physical device (from %x:%x to %x:%x) not supported.\n",
> > > > > -				be->major, be->minor, major, minor);
> > > > > +	diskseq_str = xenbus_read(XBT_NIL, dev->nodename, "diskseq", &diskseq_len);
> > > > > +	if (IS_ERR(diskseq_str)) {
> > > > > +		int err = PTR_ERR(diskseq_str);
> > > > > +		diskseq_str = NULL;
> > > > > +
> > > > > +		/*
> > > > > +		 * If this does not exist, it means legacy userspace that does not
> > > > > +		 * support diskseq.
> > > > > +		 */
> > > > > +		if (unlikely(!XENBUS_EXIST_ERR(err))) {
> > > > > +			xenbus_dev_fatal(dev, err, "reading diskseq");
> > > > > +			return;
> > > > > +		}
> > > > > +		diskseq = 0;
> > > > > +	} else if (diskseq_len <= 0) {
> > > > > +		xenbus_dev_fatal(dev, -EFAULT, "diskseq must not be empty");
> > > > > +		goto fail;
> > > > > +	} else if (diskseq_len > 16) {
> > > > > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq too long: got %d but limit is 16",
> > > > > +				 diskseq_len);
> > > > > +		goto fail;
> > > > > +	} else if (diskseq_str[0] == '0') {
> > > > > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq must not start with '0'");
> > > > > +		goto fail;
> > > > > +	} else {
> > > > > +		char *diskseq_end;
> > > > > +		diskseq = simple_strtoull(diskseq_str, &diskseq_end, 16);
> > > > > +		if (diskseq_end != diskseq_str + diskseq_len) {
> > > > > +			xenbus_dev_fatal(dev, -EINVAL, "invalid diskseq");
> > > > > +			goto fail;
> > > > > +		}
> > > > > +		kfree(diskseq_str);
> > > > > +		diskseq_str = NULL;
> > > > > +	}
> > > > 
> > > > Won't it be simpler to use xenbus_scanf() with %llx formatter?
> > > 
> > > xenbus_scanf() doesn’t check for overflow and accepts lots of junk it
> > > really should not.  Should this be fixed in xenbus_scanf()?
> > 
> > That would be my preference, so that you can use it here instead of
> > kind of open-coding it.
> 
> This winds up being a much more invasive patch as it requires changing
> sscanf().  It also has a risk (probably mostly theoretical) of breaking
> buggy userspace that passes garbage values here.

Well, if the current function is not suitable for your purposes it
would be better to fix it rather than open-code what you need.  Mostly
because further usages would then also need to open-code whatever
required.

> > > > Also, you tie this logic to the "physical-device" watch, which
> > > > strictly implies that the "diskseq" node must be written to xenstore
> > > > before the "physical-device" node.  This seems fragile, but I don't
> > > > see much better optiono since the "diskseq" is optional.
> > > 
> > > What about including the diskseq in the "physical-device" node?  Perhaps
> > > use diskseq@major:minor syntax?
> > 
> > Hm, how would you know whether the blkback instance in the kernel
> > supports the diskseq syntax in physical-device?
> 
> That’s what the next patch is for 🙂.

Hm, I think we should separate diskseq support from the notify open
stuff: it's possible a different (non-Linux) backend wants to
implement open notify support but doesn't have diskseq.

> > Can you fetch a disk using a diskseq identifier?
> 
> Not yet, although I have considered adding this ability.  It would be
> one step towards a “diskseqfs” that userspace could use to open a device
> by diskseq.
> 
> > Why I understand that this is an extra safety check in order to assert
> > blkback is opening the intended device, is this attempting to fix some
> > existing issue?
> 
> Yes, it is.  I have a block script (written in C) that validates the
> device it has opened before passing the information to blkback.  It uses
> the diskseq to do this, but for that protection to be complete, blkback
> must also be aware of it.

But if your block script opens the device, and keeps it open until
blkback has also taken a reference to it, there's no way such device
could be removed and recreated in the window you point out above, as
there's always a reference on it taken?

> > I'm not sure I see how the major:minor numbers would point to a
> > different device than the one specified by the toolstack unless the
> > admin explicitly messes with the devices before blkback has got time
> > to open them.  But then the admin can already do pretty much
> > everything it wants with the system.
> 
> Admins typically refer to e.g. device-mapper devices by name, not by
> major:minor number.  If a device is destroyed and recreated right as the
> block script is running, this race condition can occur.

Right, but what about this device recreation happening after the admin
has written the guest config file but before the call to (lib)xl
happens?  blkback would also end up using a different device than
indented, and your proposed approach doesn't fix this.  The only way to
solve this would be to reference devices by UUID (iow: diskseq)
directly in the guest config file.

Then the block script will open the device by diskseq and pass the
major:minor numbers to blkback.

Thanks, Roger.
