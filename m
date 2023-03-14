Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6DA6B9722
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCNOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCNODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:03:24 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 07:02:45 PDT
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89F78C99
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678802565;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=x7Pi9JeyEdLMkLaLvLunTaIo2KLX7orfHAf/XFSyvgs=;
  b=LY5dEb7fefT0s6CZ66Q6VXhdZB41M68OfIbWy/fbuO5NZ0RhZpYmdJdI
   JI9Og5vFjB8rcJTX5VVcRVkJ24/yY+VCYouqzlmPx/lQUeZSV7r4mTEmM
   NBAYekT9dwUGRUJUw26c8/mMMAdmJE7QtT/m+iDQLs1r/1vBTSeOCCi0M
   8=;
X-IronPort-RemoteIP: 104.47.55.103
X-IronPort-MID: 100153562
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:XyMPlqse/2Hf0Fq+zKKqQ8Fk0ufnVLJfMUV32f8akzHdYApBsoF/q
 tZmKWiEP62NM2X9ftsjO4y/pEoF7JHdzYVrQFA6qyEwRS5A+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4bKj6Fv0gnRkPaoQ5ASHyyFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwLncsYzapv/ON2PGqZ7cxq5s9FunzM9ZK0p1g5Wmx4fcOZ7nmGv2PwOACmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osjf60aIG9lt+iHK25mm6Co
 W3L5SLhCwwyP92D0zuVtHmrg4cjmAuiANpLSeblqKQCbFu7yVMfJUMyenmBjsKChkWSWP91G
 VMr9X97xUQ13AnxJjXnZDW6r2SDpQU0QMdLHqsx7wTl4q7V5RuJQ2sJVDhMbPQ4u8IsAz8nz
 FmEm5XuHzMHmLmUT2+Ns72QqjixETYaIHVEZiIeSwYBpd75r+kbhwLFSdtLE6OviNDxXz3zq
 xiaoS57i7gNgMoj06Sg4UuBkz+qvoLOTAM++kPQRG3N0+9iTIusZojt7EeB6/9Fdd6dVgPY5
 CNCnNWC5ucTC53LjDaKXOgGALCu4bCCLSHYhllsWZIm8lxB5kKeQGyZ2xkmTG8BDyrOUWWBj
 JP70e+J2KJuAQ==
IronPort-HdrOrdr: A9a23:mOy/DqAA6sFP7QDlHelc55DYdb4zR+YMi2TDt3oddfU1SL3+qy
 nKpp4mPHDP5wr5NEtPpTnEAtjifZq+z+8Q3WByB9eftWDd0QPFEGgh1/qB/9SJIUbDH4VmpM
 JdmsZFaeEZDTJB/LrHCAvTKade/DFQmprY+9s3zB1WPHBXg7kL1XYeNu4CeHcGPjWvA/ACZe
 Ohz/sCnRWMU1INYP+2A3EUNtKz2uEixPrdEGY77wdM0nj0sQ+V
X-IronPort-AV: E=Sophos;i="5.98,260,1673931600"; 
   d="scan'208";a="100153562"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 10:01:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMcTC2Qol6KIFcNvsdcwJtEeLDeZ+S+Cx7IjJxKR/dEq4lE0MzRgxH3/2mJfGsgukjmDtb/II9Xi+MZoj20zAmH+zuDuE0erqfy2jPjJma1RpnXyw8hY6fLLnjNy+1IUKN+NX84NBLfJHf4oeo/adWhFISUSfHhKLVtRgMqiiKNqRldiqna3mvd0rA15VTCUGTaJ+Y7IGMqVL8GOmEZ37vjv2NmubhPIU89cavHsTczVt8CFCobmPavRcS4mryUB1J1eH4b0wZ//WqVgqcC4FrR3GodlWqhxIjZscS3QmYFhZi+GNsHVM0JGdH1hRB4i8QtcwP7xPXC+2eia3949uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eduAfkaPs2BiUv37ci00k765OBwKbz6EiaFklRaz2j8=;
 b=PfVaJ19XZoNXENPjiVIrHG+KDaAPxj0CrT5D9XM3KhO6CzOUfAzmahEoeOCLMRjAJhXQfZ+GI1YsUEGm7ULiriZvnva3A0IfeQFBmUe6HmvljF6ZrxIXkM5Qc1RzyP5KAiBkpl07N1RCw2lwSQSkZNL+HD8HU6P/gNwAHxjFJloQTNCGkXTYGotMFgrQ+kwgFZmRYhxdk6cN6T0p9BjP3yt1rsOFjrrXWzD9MJNSkeCabJ70V26/frtE892kIYkvfYtF67ZUNmLr5/dgb0guTNMt5/+z8fsEm8ynMGl7EQ2e4Um1BxcebTtXdjdKk6kuEaaVmosNLHvVlM/nUZxRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eduAfkaPs2BiUv37ci00k765OBwKbz6EiaFklRaz2j8=;
 b=THz1LWM4FFy4KGH9TBi/3evZH6TFflzovwVWrVr8jBmmke6C98tLqk169OVUsniwI4TBfYAvo1jLQtzGyCI2LY6nvkwvBPuz58apCzplVWzszeWMZ2sUFI0/dTjJtR1I/xUKlzZORy5zOOAnOrG/ktdFNhDBP4EM9tqINkwxtzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BN9PR03MB6202.namprd03.prod.outlook.com (2603:10b6:408:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 14:01:39 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%3]) with mapi id 15.20.6178.019; Tue, 14 Mar 2023
 14:01:39 +0000
Date:   Tue, 14 Mar 2023 15:01:32 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 0/4] xen/blkback: some cleanups
Message-ID: <ZBB+POI+ipSqKBJ6@Air-de-Roger>
References: <20221216145816.27374-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216145816.27374-1-jgross@suse.com>
X-ClientProxiedBy: MR1P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::33) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BN9PR03MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0198a6-f4b1-4f10-83b5-08db2494a1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5I/JFmwyFqjydr5Qwo7IAIZnZJlA99YthCLp/u4QYECSZaiIgvjf2+gd0wMMBbuPtHQXQvLxQnWD1iRHfPmlc+qW5VJyz6ZbNAt1L+LrIQAwCX46i6lY+1sw98bVr3+O26rr24hyBfH8v138qLbWo+92ZPrEx/92RJNoPaV/omm3c+SgNEetzkL/V/O8Pv6kjtvT97d601wYzwSaSElTTaBhuL/9Mvq+CTnm9AyweLgF9ooYBW8xGX51WHwFbkvPjMvV+15tqBYtHlQ9udQpAyBzSNXvvdSVmReKrWtB9M6X6kcnaC4lVUGZLUhv3Wl00q8dDmuRDubdqODxy2mwbRPUqx/vVv5R00xG3qYwJ3BuUm8FWC1Nn6HzxkFErKsc8w6wHIwIWMF6XAKynMoNkkva9qnSm4XiY+2QvKT73N2nb6RoDFgx9j65Mz3sxbcAZIrNth7zvs5dGQPJrlxtAhPtI9tWgby+xE1dZW/8+mG0PCyipxJCgldK8csh7/MYzyXGDJaveNtYl8kQ+AZ3L3UxLwK9KEkKkaNS6ro05aO0+4uQHjB1QReGIm1mK8y9PWI0LWt74XPWxsCtTF19xPrHk5wetsQJ3nKuaID90pwnoAGnqzmd5GiTU3ItsRYmvgoAosKrlsMkbWj+RwBoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(85182001)(316002)(6486002)(478600001)(5660300002)(2906002)(8936002)(4744005)(4326008)(8676002)(6916009)(66556008)(66476007)(66946007)(41300700001)(82960400001)(86362001)(38100700002)(186003)(33716001)(6666004)(6506007)(9686003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnF1VTVXaFBBendORjA3OW5TZmFQRlh5QzUyaUVFNi8wMThGY0MwbC9vMnRD?=
 =?utf-8?B?NmVOcUFNL2ZBUEFBVkpYZHZWSklmcEo5Vlp2SkU4cWsvSUdIa3ArNHFCcngy?=
 =?utf-8?B?Rk4xY081WGRkZGc1eTRxYzF4M3ZwVTRGOTJ3NTBjTjM3dFdhK0w1amh2cEFp?=
 =?utf-8?B?dFJrbHQxa0cxN1BHdS9waHpRQWN5WUN2WUloUGJlWk52aU9saHkva2NSQnhW?=
 =?utf-8?B?cElIOHV2SGtZek9IYW56UmllYVhaQVZSRHI1dStUMllKZTQ2aExVdFBGQjhm?=
 =?utf-8?B?RlNRbXZ0S0N6b1ZUQmQ5ODhBN1V5Y3NVUnc4dXVpZFcrbmcrblBLZlN6U3Zl?=
 =?utf-8?B?QjBKNEZsOFlpbERxV2JHNTBwaEY1Mmd1L3lqZWU0NEl6TWthZFR5NlhleTM4?=
 =?utf-8?B?b2Uva3NZR04yZHdqMDAzN3BNSUZNMVJmelZ1UG1OTDlFVStGWlJGazlnZnQ2?=
 =?utf-8?B?YXFnZGRCMGlXNDdLN2xBMHVVT1hpQ1BKTGpXVjlvNGV2WkIxVzR3ZTJKaWsz?=
 =?utf-8?B?VHNqSXpQcTBuSnBzOGl4TzVPQkorNkFpWVBOVERMRVdpMDFBNUpGcEdpanhj?=
 =?utf-8?B?UnJnaDFBdlFqTXVrMWZNanhTcHRZVGRZNndIN1M2WlBWb09GUmw0ZHA1TmhE?=
 =?utf-8?B?Q2xVZnBPZ3ZmS0JVTk5pSmk5Qys3RzBiV2l3SkpMTG9mQ2hmOEVENEwzc1Zq?=
 =?utf-8?B?bnlEVzZNbktzZS9qYVFYZ3hXakNxWXJNcVZkUGl3Zm0rdE9NK1BUYlhiV3pF?=
 =?utf-8?B?YThZWXNzbnRDTzJuZFdhVDhDY2pxMGJLK0NDalBoYkltNktub0JkN3dISHhP?=
 =?utf-8?B?YUs5NklUREtocXZIeGpkVTNrVFFSWWQwMTBrSnJKTXEwNmYxczVRSWJLWXhZ?=
 =?utf-8?B?eGM2SDk1Z0NHNmI0eWxQZE9DRzUrT24wYXMxR2ZyQ0NzNWh0M0lCZ0RwdTdw?=
 =?utf-8?B?d1MzMTVmOGFYeFBsZ3ZVQU5GMmFXR1prVldZRXpaYmd1TmdGMVczd3hRTGJJ?=
 =?utf-8?B?bkVYdFZoa3NUcVkxUEpqbEZoS1lUcWNQSTk1ME8zZjhJY0p2dWRhWU4wSXRN?=
 =?utf-8?B?eExqejVrd0pla3NXbVVhMFNtTEl6SVk0Wks5eFFMNDhPc0hTdEVYbWhVWStK?=
 =?utf-8?B?ZGszSHQ3bVVvUWFIVzA2c2lnazR5UFk0Yy9nYndEYWozWHNTd1BPekhqUTdz?=
 =?utf-8?B?VjNpalVaVFJvUGRUUnlHWXpDYTl4YU5La0tubjZkWkpPM25GdlVqcWdkWlN4?=
 =?utf-8?B?emF2Und3eWpuOW9aanZqTWV6U0N4emQ2ak9mRCs0NEF1R051a0M5OTFncENi?=
 =?utf-8?B?RFowRk5rdXBIbmJ5ZXRYZ2dNVzBxMjlsa082YkRpRXlLVWtCeHdyNVJFSngz?=
 =?utf-8?B?aFBLdTVXaWRWYVpEVVFQc080NWdlVmFNbHhieitKaW5lS3Fvd04wb0ptdXNu?=
 =?utf-8?B?bVMxc3BlYWhUOVBtM2FsZHpVazZmVnhWRUxhVG5ZMmNYbXBBemxwUEFKdjZI?=
 =?utf-8?B?bHoyZGowdTN2R3lzSnZSOS9OQmk5UTh2di83eFVYaDlSZHFUK1NtWEcyRmU5?=
 =?utf-8?B?QzJlcUM3VE41T2lleEcxTWYzQ0RieFNCN1FFaGhpZHhVU2VQVmo5SjY3dVVo?=
 =?utf-8?B?MTRYQlA4Rlk4WUZzejRkRHBWZzVTYWwwVldKeS93andOdndPM2hGUlhOVytr?=
 =?utf-8?B?NjdLZjZwdmk1cWhjeDRyWVFxVnhpNDh6UUJ2akhGTnJPWTdsYTIvNFEzZzhw?=
 =?utf-8?B?WDk0U0NpMXFUbzJlRmJSTS9VSW1MeVhxaG1MR2hOT05zWHhmb3Z6eHl4UlA3?=
 =?utf-8?B?YTAvOFFVTnZVa0RIR3g5QXhHbHUvT3FjUnIzcE5LdFd6RWJiTjdvU2NKWUNP?=
 =?utf-8?B?QXpTV0M5K0dDaFFpRUpSZEtOOXZhRVErLzRDSkI0RERpTjJiSk9Qbk0vK3l2?=
 =?utf-8?B?RjJwcncwdVE1bmpaRkNFZXRUYVZIbUNTVEp4b1RtTWRkN2V3TkxkdkJLbER6?=
 =?utf-8?B?djZTQTNvc093Q3pqZXQwWHFwMHpiSjBZMGlWbWpKY2p6NVNUaERveGI1eHJC?=
 =?utf-8?B?RE1qNkdpdi82N2xGVGFLN3hrcGFMVkQ4Vit0TWRDdVZWdzlraERFMXhVb0N6?=
 =?utf-8?B?N3lrTW1qTjdaQUxEd1FrWGp2R2oyc3lYdWc4RWlKWGhCdm1ZRXlhSlFjWHVk?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KXuBWJQQXDlrjoqlPQS21XC/Zb03S5wSoh7OZJM/Mo83aow/HAp/FT+r59QqkMSLLC8InbNHtLPhDohTdqpC8BsWzreP05kKrE3ohVEvfu9qLtrBieSz0HqwAt3SPas/udiIN/gU4M1YsoOTe5gzHzfJYwO8IXRYDsrvC5szus6fs77YVMcW02THXG2OEtzwWWguitYUtfG34qmwLWjFhWtWDZJzR6x6vEXSuBbFGsH+G4eXDe0wOVVkXhbL2QazCZP1S8BcSMLqRr4LkT60OhIdqKfAx1FWHpDe63fb9jnGkuE4W0fFB3tRA2R3ThRc07k8HSrZm9K2LTCoeDZrwG+StU5JYUVOKfHKWLTSy3aKvUsXQv7QbzJTnTc7iq0VDeILYWZ4mZavi0lGIRunFlJi00I/Ry7nlKu90cE1OW/L9x2wbyYQV5wOeeMo2hjTezH5dLq/G9rcO5NaT8C9ELbZyVkcVOs3hfqdxIYbdIPu2WladnVBmhCklnZWlkPyJ3VYHEHodkH/yTOb5xncMe3qXeyeld7pDtGo8uBv1lCc5uz8G5z4GmaStpVTEBrFTjo+SXAAb3DxY5dgAcRZzJjzMByLrUTP1NzjQQ2cUWtXMTUxnCIPY2oXup5vLgdAf2d8Tk+f8AM9HTDTNluG2vGDD5/v4nQPIdU7GsT+bLPCrPDPvMLOmE2WuG6126hu4RvNd3ZiYCckMwZxl/XeP/OXeFaZh18VCl/EBlcXW5XQ4EmeFZxofHBdFiomXEBEDQd2GMkuf/WeDRcnU4fVvHxovjzkQ6DkXh/j+4VqawBaEDgavRtSij4ftY0D2B/toRX3f0TLRPa9N7vP1w71J0AYViTEDp+HoBSNyQJtbLcMBzi05lw6/P6882mKy57n
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0198a6-f4b1-4f10-83b5-08db2494a1d1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 14:01:39.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLJ4CQ19IJfG17KQaVUhDWtTERcyf2L0tZVNw9shM6Zcy5MsPelXk/Hcp6KAuovKbjDoiEnmNo47hgAjHbPTXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6202
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:58:12PM +0100, Juergen Gross wrote:
> Some small cleanup patches I had lying around for some time now.
> 
> Juergen Gross (4):
>   xen/blkback: fix white space code style issues
>   xen/blkback: remove stale prototype
>   xen/blkback: simplify free_persistent_gnts() interface

All first 3:

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

>   xen/blkback: move blkif_get_x86_*_req() into blkback.c

I've got two minor further adjustments for 4.

Thanks, Roger.
