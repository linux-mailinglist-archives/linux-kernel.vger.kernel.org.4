Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5DE716543
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjE3Oz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE3Ozz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:55:55 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11393A7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1685458553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9ti+fh3IQP2kqX6vJ8EdZ90JnboJj2ATrgwrAFuSDeg=;
  b=aDzfLjKnA8eygmqY4bbiXKAKI6STCZNZdKeg1fZAnlHU5wmDWsAsJFwa
   bjs/HSzwhWwaaRx1Xu6S/UQY4Ud/7RNu5CdVGnJ8wLOCnMqro3xyQOLta
   aVCvZZo8nzTVkns1vynoM8Kv+KimiJQrWfs0cvMg1mNekhafcm5O1bH9X
   0=;
X-IronPort-RemoteIP: 104.47.55.168
X-IronPort-MID: 110952429
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:36VewqtNODFW1mGspzm/k7m2COfnVD1eMUV32f8akzHdYApBsoF/q
 tZmKW+BOP2NYjP8coglbtjn80sPsMPXxoRnSANkryljRn5B+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Fv0gnRkPaoQ5AKFzyFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwLzMdLTuqheGPwbeWeso9h8Q/JeqyI9ZK0p1g5Wmx4fcOZ7nmGv+Pz/kImTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osjf60boq9lt+iHK25mm6Co
 XnduWDwDRwAK9WbzRKO8262h/+JliT+MG4XPOThrq832gHJlwT/DjVITn2hm8K4gXeQfP1SD
 lYG1BswopoLoRnDot7VGkfQTGS/lhwWVsdUEuY6wBqQ0aeS6AGcbkAYQTpRQNgnstIqXzss1
 0/Pk96BLTlutrKSYWiQ+redsXW5Pi19BWUaTSYATAYDs5/vrekbghvRQ5BjGaiug9vdHTD23
 iDMrS4iirFVhskOv42rrQ7vgD+2oJXNCAkv6W3/XG2/6RhiTJW4fIHu4l/ehd5KK5yYVR+Gp
 2QenNaF7/EmCouEnyiABu4KGdmB//SCNjDHqURiE5ko63Km/HvLVYNX5it3KG9qP9wCdDuvZ
 1Xc0StV5ZlOLD6pYLVxboaZFcsn1+7jGM7jW/SSacBBCrBheQnC8CxwaEq422H2jFNqgaw5I
 Y2cc8unETAdE6sP8datb+IU0LtuzCZuw2rWHMr/107+j+rYY2OJQ7AYNlfIdvo+8K6PvATS9
 ZBYKteOzBJcFub5Z0E77LIuELzDFlBjbbieliCdXrfrztZOcI35N8Ls/A==
IronPort-HdrOrdr: A9a23:A+AUDKjwIjOAh9QaMMBJVjknlHBQXuAji2hC6mlwRA09TyX4ra
 yTdZEgviMc5wx/ZJhNo7690dC7MBXhHPxOgbX5TI3CYOCOggLBRuxfBODZsl7d8kPFh4pg/J
 YlX69iCMDhSXhW5PyKhzVQyuxQouVvJprY4Nvj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3AD3V3vWnWsopzo3d9ompON+CAJuTXOXre3DT7Ck2?=
 =?us-ascii?q?7MGdsZY22GF6Q5KpHytU7zg=3D=3D?=
X-Talos-MUID: 9a23:Gtex4AVrI3YFPeXq/GH3oitYD8Zj2oqJJ00oi4coiteLBxUlbg==
X-IronPort-AV: E=Sophos;i="6.00,204,1681185600"; 
   d="scan'208";a="110952429"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 10:55:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ock+eokmm1M8B6IPSnLDsHWlI8DAxADJUHuJspJKlqtFFsJ6O3mtgBCGHMObX7Y0YTbEe5+J7M/jl8kyIao3c8kKkPf1xkzEF3zPHBXL1jbbmMvEFw+jkX2GCvXsacy1pApgUe8g0h2WLBIEB7vtXwF65GXr7wM3W9E+x+E7/srzqE51P9Vss8fM324R1Rq9/bBJKJm65ydAXiH+2HgwX8ej71TJiTFhtmBXn6p7Rc57S+bFGFJvG1o8yLs3hubXbOHM/3Xx/Isfmk/mLOj0FMn7yXFrFyh6YlO4G1HFl83e7z0iFqk8KisAd7fIqAmpPM8seQNrQ19aj3tDr5cKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ti+fh3IQP2kqX6vJ8EdZ90JnboJj2ATrgwrAFuSDeg=;
 b=QXMFw4/g8AhhmZG0GIfuUeABlWOuO1OyYqGoWMkGEcwMN/fK2jlEmsOKL8excw59KHDB3ZvKWXZLntRjLaxZcxbg99rQqjXeFYqIlvz7IAK01+uITHyx1BLZ/YvO0NMGEzLre/y2MrmcFSnJgPAQkzuXQ7SvTmiVfMcCIrP8p+ior0O5AhFCc+LDpXNIeM0gxrzRn0TBtOirVZp1zshn+MCyddeJyRiifUaXVrQap10JwJVhvVDhra2V03gPQSORRZ7XX6nRoQzgn3fH3B8eRPrbeTTkWJfDDWXYUCBMfPlsXLeZMVn1/rOqrtt8k78jU6kShx69p31+C3O27BOmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ti+fh3IQP2kqX6vJ8EdZ90JnboJj2ATrgwrAFuSDeg=;
 b=I8aMyows9BzEP9ocnyQRdjvZ7ztpMc2HGo3qH9BEctuFxipcM6voFHJVYId82htClPy7nIhWXPKrlI/9Fjhd2zNQMWktSsjKmGd4i9NtEQi+TrWkjdRaSz5FHKqnzGZYGgM86X4zc2JyKZb+hdN+zGXL2a9j9HF9M1HFGDvIO8s=
Received: from DM6PR03MB5372.namprd03.prod.outlook.com (2603:10b6:5:24f::15)
 by SA2PR03MB5946.namprd03.prod.outlook.com (2603:10b6:806:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:55:49 +0000
Received: from DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::53f7:d006:1645:81e2]) by DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::53f7:d006:1645:81e2%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:55:49 +0000
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Thread-Topic: [PATCH] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Thread-Index: AQHZjlmquto/3z2jNkiFi0kEFPQM+K9quqOAgAg19GA=
Date:   Tue, 30 May 2023 14:55:49 +0000
Message-ID: <DM6PR03MB53725BBA63A682EB14050FC9F04B9@DM6PR03MB5372.namprd03.prod.outlook.com>
References: <20230524160558.3686226-1-ross.lagerwall@citrix.com>
 <6a2e6371-97a5-397d-ca1a-247b610b49d3@suse.com>
In-Reply-To: <6a2e6371-97a5-397d-ca1a-247b610b49d3@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB5372:EE_|SA2PR03MB5946:EE_
x-ms-office365-filtering-correlation-id: a4eb1a23-0c2c-4f33-51b0-08db611df4be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70xPPktU8f1gr1YMwqjToguvFWRuh/64sIpn5Oj765bYXq8z43FvkOam1FnYpZUR4cEmkZhdyeA/g28GW7JwYUFM3Km12KfEi/1n883cofWZ8egRP1xvV7ySjoG17Z2+QxehBhyGk7UgR1xNrcmdsZ8Okhm1Nj3RwrMPxgCwQu6Y8UIYAmqrsl8mzT9KLyqGNGLWEexlNTubguclbLfm5bLkU7kZ6dJG4BppHZxBZJaZYegIYqV8MnXYgwc/5ZTQCQ35IFOomocv+SmUs4tnjMR0T8BjsUt3Opt7p99Da0tbt+WMWYMO6Kx1bsBS/pr1G8iuBJB0HP4sr/OPMvHn9Tpf0k+DStawTmYWV6BEfXhCRc0hQah68v+0mnqoAgHv3e2FSrcVhQVzz/h9kK3DHALSvYsuibUqq7GGTSQU8eX42xoUYgrfZS7TSUxsO0YmRY8hbPmuJ8RPK171TNVzrxnu/lr2XspZk73dpRVauoOp412lUOJMjo5Y6fwulOG2IDj28tTqODzxf5pZr2yr92Ip+C7ZrtB822hjI8jubEW+z8M2CWEycr3wl5oDi4D/F/2BF3TNMNAUXC8YnHkgAdLAWZ++/YzT+UcATL3TFrIrIn49vTSee9nOXPClDr2M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5372.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(186003)(9686003)(6506007)(2906002)(55016003)(53546011)(38070700005)(83380400001)(4326008)(6916009)(316002)(71200400001)(91956017)(76116006)(64756008)(66946007)(66446008)(66556008)(66476007)(41300700001)(7696005)(38100700002)(122000001)(54906003)(82960400001)(33656002)(478600001)(44832011)(26005)(8676002)(8936002)(86362001)(5660300002)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OzICd2agXSojOdeiP3V9j+32Ytz8HwM1JsKw44nPTL1Bo1CNCcsSEsjuwR?=
 =?iso-8859-1?Q?tqKtl6uHrDez5NyHJ2L9olaisrrvlXmZoz2hpOzSYcsgrtbb68F1HR+zzL?=
 =?iso-8859-1?Q?eNYEVZl5Yd7qE9ZcCFEMY9iEm73j10HyoyFsP9ydCpXff3A0yrTVNrhuke?=
 =?iso-8859-1?Q?jvhyWoSiNLBeFvPVDssH03TME/lEq8ZYATi0FrQaBQM2IvulzVBWLjbPo4?=
 =?iso-8859-1?Q?ELY67QTyaPX0J+rhLvaswFQFMVDr0eOFcpGFIUoyMtcivHc7cH4GGVeAL+?=
 =?iso-8859-1?Q?AR8OYORyqacpvNT6CGBfM6ztFR1npwI6LqwZK7iVZbXlsdbbaFlGljjGAh?=
 =?iso-8859-1?Q?a/wHOXa2uGadpYrh8vW1z3Q7QBIK0tkefuqf7eGhXqldOoOUfLgdGUi/GB?=
 =?iso-8859-1?Q?x2YXGZBky/ODL1+y+u8RB4vc38azdMo0iv48liaI50jyhzyuScehH09OXk?=
 =?iso-8859-1?Q?whXh5Tgeyl5B+gbSk4DlMcN2s6VEuycSVtqDneuloFtmWohSSQPnWdT07v?=
 =?iso-8859-1?Q?usJXYiZpMthA2NQIfysouC1ZSKPobHFp1jouruaIuUFFqpmwnsa7gf004J?=
 =?iso-8859-1?Q?nk0kHOlJZ45gdN6ht/Ga7aWe6Os+IBMAL9Pj6yvI+iakGThbJGD13es91w?=
 =?iso-8859-1?Q?8kbki/0g6J5mPOiESJJONEyniuneFuQRkbK0yIP8gwPwyEhpD7wLtu/dVB?=
 =?iso-8859-1?Q?vYvN0M6anqV7URUmAUKls/Z+TzLvJY5Rgo46qCvDpdMPOWw3LEovVO07Tn?=
 =?iso-8859-1?Q?uY/RYcs+WfStk5Dd29cBfcR12gOM+TL032OYmc64+ufuT/BECX8dFznnco?=
 =?iso-8859-1?Q?uRonxgnR7y4x64MS0Ot4CncZcJmDz1HrpbtaFA6N7Q+0a5YuAjIARnoepQ?=
 =?iso-8859-1?Q?BsnJ8JiEyhOsjjFELy/+bxSwJTGxTCdwf+2L9nJhFrHjjUKe18ZOOyxOfl?=
 =?iso-8859-1?Q?PJsItMmX7iuaq9JlOQUaJ0lc90reu2vMhZlorLbzzxadZxovu+dhbocCPb?=
 =?iso-8859-1?Q?nekbzJ7Jr5GXTa5v/F146NPkc7E54PIMJ0Su3JA6SQDXzqubuL5xFbtDOb?=
 =?iso-8859-1?Q?i9N3hl0nw5Tvuxl8dmudAS/YYyCTtcSV99kHrudGLbgvFvvOFz9JB2WiaI?=
 =?iso-8859-1?Q?DhdueV8vg1lcN4AhNSU0QQP3dcRmdUEhgn1eenMRo35hRGCtYEL/MIjqPG?=
 =?iso-8859-1?Q?xVqfVLyTPFcDmulmlJUSN+OpzqtreD3GUOQGudlmjMwJIxfbQMKPia2fi4?=
 =?iso-8859-1?Q?aE68C8Mmqx4zwChr04YWYVgTGb670LkHxeT3YS8UAOe37nDewOvGtNXb0Q?=
 =?iso-8859-1?Q?eGahTmYt5e8UDXPBYnlQ9QDPlVT3hjeki3PF4q3w6ef6dDVgfkSVf+aL9W?=
 =?iso-8859-1?Q?N20PjpnCRIuZXAEMRryI3K/ZmovWz1q5QRAcZ7OBM7iW6P7dC3Mk+dc4H5?=
 =?iso-8859-1?Q?kq6aK8G8CAqyqceUsQmR/d0oFtzQoQPeEM6zxKEIB0jBIWQosVguJ6kKV4?=
 =?iso-8859-1?Q?CMRGkcxRwofTL0BimcvMZG9oOE/m4pq9TIdEyaSowUZotCpPcW0uijfk/O?=
 =?iso-8859-1?Q?lyQgXf8PXJ0ocKa3ZtBB7wa3U65kGxTtGjX6l4BrFnBGi5UrSITtdPCp4O?=
 =?iso-8859-1?Q?i3fUurCPxbOratMLQ2AhsWpQbG3IDRJzso?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?NTouaXZnnzIfY+WzTNaJ/CgJqwau3wm0GDZvE16hJuWaTsoJ2jFUr6j75X?=
 =?iso-8859-1?Q?8N+ds9xi6eQw/gCfprYYFZcLglvKvhtzCu0pCRBeF2SjH9rHPU70RUFHre?=
 =?iso-8859-1?Q?K4NOv4mGGh44vvFzZfpvhxSNBygtacwJU6y3H9GRdejyED/H1vNvoa7jQ6?=
 =?iso-8859-1?Q?rpj1LCXbeAwbV4Nktb05Alx28Y4iN7PBYKUGC8AeUmxBuJjXDMi9zgTh7b?=
 =?iso-8859-1?Q?zR9mDuw4mlL1zdt1zZeIlALJ1CZSjv+w9Xf+CmhzGlJ6cHy4HAyaHqbgBm?=
 =?iso-8859-1?Q?m+Auq+YICSEM6LzrZsMpeHQ55C1hJ9lnbbZo9VlzeS3tPxJ2Mdx3MBKGlR?=
 =?iso-8859-1?Q?yz1qRfeh1do3feCQ0XLGc+1clktc8SoTEIHIf/67cZ/kdKYHzZN1sgI82/?=
 =?iso-8859-1?Q?R9YSC8WHqOQuhrxJxXD/X2Jmp1jEDZX3YkcH0h05IOeI6Wc37DPAyYMXNI?=
 =?iso-8859-1?Q?fxVqgRedQk6fhE4U9fhXLlgmB6vKo3CQlv+3FOUe1+uwviBlYSZD23JJTw?=
 =?iso-8859-1?Q?H9AYDIhPgekMuHMWS8NGt0eUw6yn8lWuQ4rd69zl37f+5rkgqAZFB+QlpH?=
 =?iso-8859-1?Q?juH+hvuq7YKBeM/gVm7sBd+OOmMZAksSZZAGCPAy5r5OBjbQCrA1eD/AgM?=
 =?iso-8859-1?Q?TYUFJYPvyGHkzVhSbRiQkQ+zL+H3Vuo8qTeDf/E5TnUE7yM6vMqZRtn0Y3?=
 =?iso-8859-1?Q?TEyOcsb5zw/wMPxvbAYNVE7bXsqWXeVyGYgzFXx9+jAIHRjU8WJlrBsys8?=
 =?iso-8859-1?Q?Hh3LnncMNhMEGRr5Lk1GGCBNqJGVTiqSiKIPl67P9rBcNQ18VW3McmshlI?=
 =?iso-8859-1?Q?9VGdV2ArOyApm1h/Z80vv2AbfxdNuIt23JCyy2zHGq5OxjFeDxAjCq/Ciw?=
 =?iso-8859-1?Q?3krG3Sbma0khSLuwDubO+s0reJqOW1mKV1XgYAH1HnCJfCsGoxcy2ov0GL?=
 =?iso-8859-1?Q?mK2SLNU6ysDYkgMZBlhKVXuYeYNqPJKcVgJ6kdmi5tm8dLCO20VEg/2y5M?=
 =?iso-8859-1?Q?IPPh7nnzAqnvHt5NJjD8R95AA4FLHj/GEioBqWBTqUMToTox5C73Zmjg63?=
 =?iso-8859-1?Q?aHruO0OqVbXzjVyVxRSSUqU=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5372.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eb1a23-0c2c-4f33-51b0-08db611df4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 14:55:49.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dM83QGKtwh731VOIt9r/qL9lDMYFtHTuEZ9kjHooNNh9lrm3mgL1MPl5fscqNE9GQvaO8Ho8Sx2v/w5LG44/WUvDFzViAKKm9xIXR2R6OH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5946
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jan Beulich <jbeulich@suse.com>=0A=
> Sent: Thursday, May 25, 2023 10:31 AM=0A=
> To: Ross Lagerwall <ross.lagerwall@citrix.com>=0A=
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;=
 Borislav Petkov <bp@alien8.de>; Dave Hansen <dave.hansen@linux.intel.com>;=
 x86@kernel.org <x86@kernel.org>; Juergen Gross <jgross@suse.com>; Boris Os=
trovsky <boris.ostrovsky@oracle.com>; Peter Jones <pjones@redhat.com>; Konr=
ad Rzeszutek Wilk <konrad@kernel.org>; linux-kernel@vger.kernel.org <linux-=
kernel@vger.kernel.org>; xen-devel@lists.xenproject.org <xen-devel@lists.xe=
nproject.org>=0A=
> Subject: Re: [PATCH] iscsi_ibft: Fix finding the iBFT under Xen Dom 0 =0A=
> =A0=0A=
> [CAUTION - EXTERNAL EMAIL] DO NOT reply, click links, or open attachments=
 unless you have verified the sender and know the content is safe.=0A=
> =0A=
> On 24.05.2023 18:05, Ross Lagerwall wrote:=0A=
> > --- a/arch/x86/xen/setup.c=0A=
> > +++ b/arch/x86/xen/setup.c=0A=
> > @@ -772,8 +772,14 @@ char * __init xen_memory_setup(void)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 * UNUSABLE regions in domUs are not handled and=
 will need=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 * a patch in the future.=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> =0A=
> I think this comment now wants to move ...=0A=
> =0A=
> > -=A0=A0=A0=A0 if (xen_initial_domain())=0A=
> > +=A0=A0=A0=A0 if (xen_initial_domain()) {=0A=
> =0A=
> ... here. And then likely you want a blank line ...=0A=
> =0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_ignore_unusable();=0A=
> =0A=
> ... here.=0A=
=0A=
OK=0A=
=0A=
> =0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Reserve 0.5 MiB to 1 MiB regio=
n so iBFT can be found */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.entries[xen_e820_t=
able.nr_entries].addr =3D 0x80000;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.entries[xen_e820_t=
able.nr_entries].size =3D 0x80000;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.entries[xen_e820_t=
able.nr_entries].type =3D E820_TYPE_RESERVED;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.nr_entries++;=0A=
> =0A=
> Surely this can be omitted when !CONFIG_ISCSI_IBFT_FIND?=0A=
> =0A=
=0A=
Yes, good point. I will fix that.=0A=
=0A=
Thanks,=0A=
Ross=
