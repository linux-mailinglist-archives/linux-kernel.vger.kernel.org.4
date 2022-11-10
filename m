Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D276E624348
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiKJNd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:33:53 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE8305;
        Thu, 10 Nov 2022 05:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1668087231;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=IyoEvG2Wg2e5n+UsLlMWKTVh6rIPFbab2153GGZp9rg=;
  b=cXT47kUCYmRIaFBaf5To5Yw7w/MNqFkUm3NGPR997oBpun/USc2J9XgT
   vjCUNK5Yyn5Ul0o1LGENCUrNySyktGv7wN3eSVDvntcdACGh0TpDJPuWc
   3+JdEwVUOM2Rx+A9MYo8J7QXchJDmlLpTzpc0gTu2gaTgfaRzZ9u/i4lo
   4=;
X-IronPort-RemoteIP: 104.47.70.104
X-IronPort-MID: 84560070
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:I7B7uaLoiU6egehcFE+RzpUlxSXFcZb7ZxGr2PjKsXjdYENS1zwEn
 DFOXGyDPvvcZGT2L9wnb4nn8xtT6JGHzYVnTwVlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHv+kUrWs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPdwP9TlK6q4mlB5wVmPakjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5qCGxQ0
 McmcgoONDSbmN2Lz4C7aMBF05FLwMnDZOvzu1lG5BSAVbMMZ8+GRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/VvpTGLkGSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iLw27GXxXyjMG4UPOa06PREmVjO/DUsUBANX2m0nKSEsXfrDrqzL
 GRRoELCt5Ma8E2tU8m4XBCipnOAlgATVsAWEOAg7gyJjK3O7G6xCmEaTzIHZZoss98eQT0sy
 0/PntX1CDgpu7qQIVqc7LqSrDj0IyEXK2IPfi8sQg4M4t2lq4Y25jrDR8hiHOi4yNfyCRnxx
 SyHqG41gLB7pc4H2qq88FzKqyihqpjAUkg+4QC/dmes9AB2fom+fKSr5ELd4PIGK5yWJnGIu
 nQemtnY9+ADE5qNmSqOR80JHbe097CENiHRhRhkGJxJ3y+3+niiY4lLpil3IktzL9gNdTbBZ
 E7VpBMX5ZlPMX/sZqhyC6qzBN4t1rPIDsn+W7bfad8mSoB1fROJ+ztrIEKK3n7gig08wf8XJ
 5iWa4CvAGwcBKAhyyC5L88N3Lluyi0gyGf7QZHg0w/hwbeYfGSSS7oOLB2JdO9R0U+fiADc8
 tIaPc3VzRxaCbX6enOOqdJVKk0WJ38mA5yws9ZQauOIPgthHicmFuPVxrQiPYdimsy5i9v1w
 510YWcAoHKXuJENAVzQApy/QNsDhapCkE8=
IronPort-HdrOrdr: A9a23:b1ezQ66VjEGx9hx/wgPXwSeBI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc6Ax/ZJjvo6HjBEDmewKlyXcV2/hpAV7GZmXbUQSTXeVfBOfZowEIeBeOi9K1q5
 0QFJSWYeeYZTYasS+T2njDLz9K+qjjzEnHv5a88587JjsaEJ2Ioj0JfjqzIwlTfk1rFJA5HJ
 2T6o5uoCehQ20eaoCeCmMeV+bOitXXnNa+CCR2cSIP2U2rt3eF+bT6Gx+X0lM3VC5O+64r9S
 zgnxbi7quunvmnwlv31nPV7b5RhNz9o+Ezc/Cku4wwEHHBmwyobINuV/mruy00mvim7BIQnN
 zFs34bTrdOwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCuJa7LgpOCfx2g4FhpVRwa
 hL12WWu958FhXbhhnw4NDOSlVDile0m3w/iuQe5kYvGrf2UIUh4bD3wXklX6vpREnBmc4a+a
 hVfYnhDc9tAB6nhyuzhBgv/DSuNk5DbituDHJy+vB96AIm4kyR/3FouPD3oU1wi67VM6M0gd
 gsEp4Y5o2mHfVmGJ5VNaMmffadLFDrbFblDF+ySG6XZZ3vfUi94qLK3A==
X-IronPort-AV: E=Sophos;i="5.96,153,1665460800"; 
   d="scan'208";a="84560070"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2022 08:33:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF1EcmabSMYcK2N3bfpBwoN1XHD2XSeb6kId634wkNO4EHC0xs4Rj3G6DULN3l5Ne+vDKRWEIsqDwQ3vONa0KVdvRyL2XFYI8izkygefXHhl0pbedDz9vQIfbyVoLW+2pW1GcXYAIiFCuSzUCwuYLLrm2hhSdP+GXIODtNXLJE9nTbN/8G1QixTECXyTxDcvTT01qDuUHRFNiz/dz93cmYtS/9r15WvPcd0ga0u9lbeosKV3BAXQgGfWi98+7tQdkFPzetI7F2o5sa2ACbgZJ9o3kFHigLTTs3Rc+krcA4EInBJ+m1IcM/M89qrfA3Te02rVX/PBPaeFpiVhaPGi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzqqmd9ZAYBFPAQ7LVpanx8nD/Gwxq7UiI84XX0ieBo=;
 b=OVv27C0AMKFuKRleORmG59j5CefvLFRtCInZBxe5GWuextJR7Ayu8w076yhF8gLtGTFouiKOKsiwKIdB8cPe4uIPIWCG7AfPkrGHlYiWBmx/Ddyz0KTrAzcPBUQSaTnO5V0jsNld/vO1ILjjSuuzxTKGUaLXLjLG7Tn44Gip8BrXn85Za775TayW42+PkoC2I7zupNSXDoou+w4i2bGbjQg4HZFZaVhoUTlv5LZXDkeK7UMfsYFM+9OP6cr7hwDJ+r0oH2jfHANVLGpvsb1dZPtjNJ0vHpaErhIbUeW3ZsEje1WXsfbYdWMsdQKq5ltzBuxMF1KNyTacCgA3NEK+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzqqmd9ZAYBFPAQ7LVpanx8nD/Gwxq7UiI84XX0ieBo=;
 b=HnY/ACftCbXdWQQmJFRiN5KyyEbEd1QJQee2rXml56gzN3MELdtLqmpBnnYuopmsJv9IDvFrDZeUvtLN0Nb1xhCqXOz/8F/OtnSjiiWSjsULAovCH8DIfUVJeaQwfglpowJ0hIWkedwtB2T1sCPLaO3FXOAVdCQvrzcZqQKspR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by SA2PR03MB5819.namprd03.prod.outlook.com (2603:10b6:806:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 13:33:43 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::d197:992c:4dca:3c4c]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::d197:992c:4dca:3c4c%6]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 13:33:43 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     Roger Pau Monne <roger.pau@citrix.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        platform-driver-x86@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2] platform/x86: don't unconditionally attach Intel PMC when virtualized
Date:   Thu, 10 Nov 2022 14:33:35 +0100
Message-Id: <20221110133335.78442-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::14) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|SA2PR03MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1986a632-e536-4eb5-c802-08dac3202f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spL8Fdc+a1fLZywELToiFvlhtLyOGiYl06PODCz3g4wUvBm9UyGuzYgt/qa5Ph807GQ/V8VR8In2x2QxgoYEbFBK+aYb4AcfF8FHGfceziCrOLC+2tmtJJsuiyTavLjLdJCbC4k3sijyQSaY7LA3pCDWSWA554FxsQr+TdNzu3L+uCpzG7Q2Zf6QTIqiWLZC4oQ4jvkUeU6K9gZFvVQ33L/XScMoNmrVzXJPfcMa3yVwMmGAN+eXpcbD/9rYwfCnr9va26EdBp1hfmXB/D5PFimDiy2NVT7MC+cAH72vGNjmgR6B6FqllWnud/DdDN6XK6ltrdrKifc8qYqs0WAZwiY77grcEM8wMolVWtMID5f6ZU2QdcLr2Io3ERX9TOe6ZIa6X4kGJWFxq3OcukmaRFyiYYk70USXPuodu3L0Z77Wc5BC1Op8uJaUhHcAIFr2/vGkJy1WtJ2+lyamOZRQseLK00a22qEKhrKdi1TCSWyX0/RJ8YwXORkHmraekmxjtsp3d6dA3iJKqXnbL2VqaArir33RbVvmWU9gZysZxfwRPrZMTTdZZZxRuztv+tAtA4fu9/95cXPKDqcH5KBU0N5WGr75PGBriToEExxBfj40s4c6pXQfQdKkrcNH8GB9i1NFCCjYQYBvebVYBf9ok0Oygeh8J1lUOfUHb6ClOaoKeHNP2cFQ6Nv8bTEZLvGlOkniX4rAQWrgJ07AjNuxDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(86362001)(316002)(66946007)(8676002)(66556008)(66476007)(4326008)(82960400001)(38100700002)(36756003)(6666004)(83380400001)(2616005)(6506007)(186003)(26005)(6512007)(1076003)(478600001)(6486002)(8936002)(41300700001)(6916009)(2906002)(5660300002)(54906003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21pdmhiOGtveUZPOEFET1krUkJUOFprdHhweGVqdHJ6VXNLck5PQXhCT3d5?=
 =?utf-8?B?emhEUS9jMTJrVms4M1U3ZGJyb2RZRXhXYUwzSWJaVjE5MTZSS0tMK1lrK3VQ?=
 =?utf-8?B?WFVPMFRTU0pDdWpMQ1J6UlpJVWZ3QjhSd05uN2RBcnBFZG03SEl2Q1RDbmJx?=
 =?utf-8?B?RXpCRE9hQ2tGdkR3TC9IRksxSExzVnVhZFU5a3N1SHpiL2lLNTVrNnU5TS8v?=
 =?utf-8?B?NWc5amNCNEtxZWFEa3Z3b1N2VEtEVWxlOExDTk1jM1lPNDNuMmpXNVVtUng4?=
 =?utf-8?B?T0lPajlTdEhjZ0dDUWNWb2xvTFd1RFJLcVZiMldNR0drTXJ1bnZNcUZCT1No?=
 =?utf-8?B?TmV6ZHpXZ2U0U2h5UDdmQndFZytQclFlaFd0TUVVc2F4SVg3MVNjU0xycUNv?=
 =?utf-8?B?Qy9HSWttODFZdStYNVNsaVJiem1IbzA3TGx5ZzVZVnFyWUZlbml5YVlMcm96?=
 =?utf-8?B?Z2FEL2VVRFRiQUVUMWMxV2tyQytULzVRUHcwcG9oOWxSTWQyejlWcExGeXg5?=
 =?utf-8?B?ZEFBaFJpVm56dG9XcUNyOEtKTElkVUZXVjVIejMyTjhDOWp0R1NveGtUOVpV?=
 =?utf-8?B?eGoxN01Td2MxVndsYkx6QW5BUEt3MnYzdDNCaDlrSFJsaHArQ21HalN4T3Ju?=
 =?utf-8?B?VzRULzB1dGtuNmJMNkVUdCt0bDRSV25LMVdBS1R2clUrdENtU1J1aHFPdldX?=
 =?utf-8?B?cTV0NDUzVml6eWtNbGJRTVJ2cHNLK3F0NCtENzd4dDRXaDhrc2RhV1FjaHlT?=
 =?utf-8?B?clVvVndOZStWVzJhTjR4bmtYTE9RL3FYd2VnK2tmclg1MTJVWG53dUpOczk1?=
 =?utf-8?B?bUhiWktseXFBUlhXeHJ6aWNvUmJLUURoUndVNWQ2WEJYaDlCUlV5WDhOM0pJ?=
 =?utf-8?B?VFdOTGxGWDYzMEprd3hxUUlBemZQdkZOUjdTb2V2cGFYUThibklieC9SMjNp?=
 =?utf-8?B?ckUzVTZ0ZURReDdvenAzVklyTkNsalZZNERDKzJudGVYYmRxUzJaR2FqT0lM?=
 =?utf-8?B?enFsZ3VxMENXRk1RMXZYRGpTMStUcTNkZUVDNTlNeWw3M21yU05Wc09LUndR?=
 =?utf-8?B?YnExY2Q1VDFBQVc2Y3B3RXlXS2c3d1VzRk1sUGhPRjVQWTB4OEhHaEFvdmto?=
 =?utf-8?B?K1ZKVHQwMTd3bjlPS0ZSUW9BNFI3YWpjeUJ0dXdTUHgwcUhwdkVOME8wZlFw?=
 =?utf-8?B?L0hpMzREYVdReG0vUzlES3ZYTFg0a3NqVGh4eGtTWkVOellvQ082WHdMSGlI?=
 =?utf-8?B?YUptM3cwRHUyVXQzMC9reGtmck1JUHdGRUZhcnlWVmpOVWsxVFZ3WS83TkFM?=
 =?utf-8?B?aGtubnREY3dTTFVsRDg0MExIVDJaNUhaTnBNdGhCU0orOUZhYUdTVllWVjNz?=
 =?utf-8?B?ODlhakJweitmYTh5L3AvODZDMzEyRUpTWFdoVERjQ01mNzZScGxHK0N3Ritq?=
 =?utf-8?B?YUQ3aVdEcjVLVjNxN0szRG1jaFgrRzEyWlFHMEF6VXpVWmpNYXhheitHendN?=
 =?utf-8?B?bkRVZ0wyTDNCMVo3aHdxOU9nRDFFRnU0YkJjRWZRR0EvZ04zN3pCZzZqNlVL?=
 =?utf-8?B?VDFzZ3lwSDUxV2ZhY1krazRtbHBNUDk5MXpzS3dqQmpFMWhEY1ZCREg4bVdG?=
 =?utf-8?B?dG1Gb0VBZWhEVWlId2J5ZjZGQVdPVERqcUUrT3dYRDB4SVNkTFcrVTRUOVhy?=
 =?utf-8?B?a3RBVG4xVlhoTnhEaFN4dlcvemxRS1JDb2hiUlJsUmRNMFl5WkxJVlBWL1JP?=
 =?utf-8?B?RVBBemVJajdLbG9ERStxQnJZZXdhTTc5Zi91aEczeU02ZFdxczVpeVREYzlY?=
 =?utf-8?B?NVhKSWVwQ1ZpdmRhZDFONnQxa2RFZ21sb3hkQlVqQUJ2SDJNRzl5QnhxUXdT?=
 =?utf-8?B?Um40QzFPRnc3ZlV1NVZtNzVwNlNtU0xHNTRzTThCNzUyL1dMbnhqUFI3MlZs?=
 =?utf-8?B?Wk95UkNzME43Y3ZwMVBYMHZpM1ZCTVN5SER1YW1NRkJHU1l6elRXRnpsVjFZ?=
 =?utf-8?B?N3ZBWlpPbjFtWm16T2krVzFEaEdlVVpvVTg0Z0VMVTlLZGNwZk5GbmZHZDBI?=
 =?utf-8?B?dnVCTTdnNXA2RTQxdHVYTk1kNlZvazlCK3d1Z3pqYVRkbHFHRExRQ0ZJcE1a?=
 =?utf-8?Q?CCxzJxrFPfE1e6bk7zrXRfCoP?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1986a632-e536-4eb5-c802-08dac3202f7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:33:43.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaAybgyj35Sf5+LBUOcKMGDqbDZuwC6stspApM2Y/nhnUeb2aYqUjC7u/0eJN3hn5QLj73gdJRDI8n2KNFf+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5819
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic in the Intel PMC driver will forcefully attach it
when detecting any CPU on the intel_pmc_core_platform_ids array,
even if the matching ACPI device is not present.

There's no checking in pmc_core_probe() to assert that the PMC device
is present, and hence on virtualized environments the PMC device
probes successfully, even if the underlying registers are not present.
Previous to 21ae43570940 the driver would check for the presence of a
specific PCI device, and that prevented the driver from attaching when
running virtualized.

Fix by only forcefully attaching the PMC device when not running
virtualized.  Note that virtualized platforms can still get the device
to load if the appropriate ACPI device is present on the tables
provided to the VM.

Make an exception for the Xen initial domain, which does have full
hardware access, and hence can attach to the PMC if present.

Fixes: 21ae43570940 ('platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Acked-by: David E. Box <david.e.box@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc: David E Box <david.e.box@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
Changes since v1:
 - Use cpu_feature_enabled() instead of boot_cpu_has().
---
 drivers/platform/x86/intel/pmc/pltdrv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
index 15ca8afdd973..4f9fe8a21d8f 100644
--- a/drivers/platform/x86/intel/pmc/pltdrv.c
+++ b/drivers/platform/x86/intel/pmc/pltdrv.c
@@ -18,6 +18,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
+#include <xen/xen.h>
+
 static void intel_pmc_core_release(struct device *dev)
 {
 	kfree(dev);
@@ -53,6 +55,14 @@ static int __init pmc_core_platform_init(void)
 	if (acpi_dev_present("INT33A1", NULL, -1))
 		return -ENODEV;
 
+	/*
+	 * Skip forcefully attaching the device for VMs. Make an exception for
+	 * Xen dom0, which does have full hardware access.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
+	    !xen_initial_domain())
+		return -ENODEV;
+
 	if (!x86_match_cpu(intel_pmc_core_platform_ids))
 		return -ENODEV;
 
-- 
2.37.3

