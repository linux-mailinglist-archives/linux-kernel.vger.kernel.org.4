Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7066DFE03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDLSwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDLSv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:51:58 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC8E86B1;
        Wed, 12 Apr 2023 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5014; q=dns/txt; s=iport;
  t=1681325498; x=1682535098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FQeq+XEUzVqNuU74RdQezQRFvfPb5pDZvmqlwL4xY7o=;
  b=a+ufsXnZL8QluCXFUdYXrngXP4SKRvlkZhZGVYDG8HMnHf6B9Xg4BUWO
   JP90OONqtaVP2ZNG33AzA9q/hCqR6DPlLXDQeCJP8/MH671EB51NKZ48G
   XJvwuFvdJOFryBkjZOVHwebap1uFyGsqKKVbP/QxyJaHe6msGhLtBkWmf
   c=;
X-IPAS-Result: =?us-ascii?q?A0AtAABB/TZkmIQNJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBW1JzUwgpEkaIHgOET1+IMAOSIIs8FIERA1YPAQEBDQEBRAQBA?=
 =?us-ascii?q?YUGAoU8AiU0CQ4BAgICAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBA?=
 =?us-ascii?q?QEBHhkFDhAnhWgNhgMBAQEBAgESKAYBATcBDwIBCBgeEDIlAgQOGQ6CXII6I?=
 =?us-ascii?q?wMBoCUBgT8CiiB4gTSBAYIIAQEGBAWfIQkWgSsBkTknG4FJRIRAPoJiAoEjP?=
 =?us-ascii?q?YYgIoEMmUAKgTR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOb4FJgyoEAhRFF?=
 =?us-ascii?q?TcDRB1AAwtwPzUUIAZYgRkkBQMLFSpHBAg4Bhs0EQIIDxIPBiZEDkI3MxMGX?=
 =?us-ascii?q?AEpCw4RA1CBRwQvgV0GASYknwk4DgEjJgYHHgElD2ktPwEaE0UDkhOxJwqDf?=
 =?us-ascii?q?p1ngwZNE6kvl3OkYYMVAgQCBAUCDgEBBoFjOoFbcBWDIlIZD44gGYNZj3l1P?=
 =?us-ascii?q?QIHCwEBAwmLRQEB?=
IronPort-PHdr: A9a23:dteXKRzVGA7e3ZbXCzMRngc9DxPP8539OgoTr50/hK0LKeKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YAZ8IOX4HpHbp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwPnIJ4I6Atyx3E6ndJYLFQwmVlZBqfyh39/cy3upVk9kxt
IronPort-Data: A9a23:ehxLiqojfrvPLyeQzz2WWo9RXi9eBmLRZRIvgKrLsJaIsI4StFCzt
 garIBmObPyDajH1e9F3PIS3oEkFu5CGyNE1SgQ4rShkEXwS9ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7xdOKn9BGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 JWj86UzBHf/g2Qvaj5NsfrYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95feK3SAtpyOkXbPKVXr7eV1Cxo2Nrwxr7Mf7WFmr
 ZT0KRgEahSFwumx2r/+E7EqjcU4J86tN4Qa0p1i5WiGVrB9H9aaGOOTvoUwMDQY3qiiGd7Sb
 swYZD5wZTzLYgZEPREcD5dWcOKA1yilLWMJ8wj9Sawfx0GD6Axa2aPUMdvaXMbVefd+vBqUn
 zeTl4j+KkhKaIPAodafyVqoh+nSjWb4VZgUGbmQ6PFnmhuQy3YVBRlQUkG0ydG1h1C/UN9DM
 UEZ0jQhoLJ090GxSNT5GRqirxa5UgU0Ut5UFagx7xuAj/OMpQ2YHWMDCDVGbbTKqfPaWxQz3
 FO2mIP0Wwdm6pOSZ2KG8eyUpgKbbH19wXA5WQcISg4M4t/GqY41jw7SQtsLLEJTpoCqcd0X6
 23SxBXSl4n/nuZQjfXmoQyvbyaE48mXE19kvm07S0r/tmtEiJiZi5tEALQxxdlJNoKQSFXpU
 JMsxJXGsLtm4X1gaEWwrAglFbWt4bOONyfRxAc3WZIg7D+qvXWkeOi8AQ2Sxm80b67omhewP
 yc/XD+9ArcPZBNGiocsPuqM5zwCl/SIKDgcfqm8giBySpZwbhSb2ypleFSd2Wvg+GB1z/FmY
 8zEIZ3xVihCYUiC8NZQb7lFuVPM7n1hrV4/ubigp/ha+ePEPSXMGett3KWmP7xghE97nOkl2
 48Pa5TVo/mueOb/eSLQuZUCNkwHKGNTOHwFg5I/SwJ3GSI/QDtJI6aImdsJItU594wLzb2g1
 i/mBSdlJK/X2CevxfOiMC4zMdsCnP9X8BoGAMDbFQ35iiZ6Pdfws/t3mlleVeBPydGPBMVcF
 pEtU86BGf9IDD/A/lwggVPV9uSOqDzDadqyAheY
IronPort-HdrOrdr: A9a23:zfWoQaHeMI3Q/EIqpLqFTZHXdLJyesId70hD6qkvc31om52j+f
 xGws516fatskdvZJhBo7290KnpewK6yXbsibNhcotKLzOWxldAS7sSo7cKogeQVxEWk9Q86U
 4OSdkENDSdNykesS++2njFLz9C+qjHzEnLv5al854Fd2gDAMsQjHYaNu/YKDwKeOAsP+teKH
 Po3Ls+m9PWQwVvUi3UPAhgYwHrnay6qHvhW3I7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl54242svLiSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CChjYou+uigWxa0u
 Uk4i1Qevib2UmhOV1dkiGdnTUIFwxeskMK/GXoxUcLZ/aJHA7SRfAx3r6xOSGpmnbI9OsMo5
 6jmVjp96a+yXj77XnADx+ibWAxqmOk5XUliuIdlHpZTM8Xb6JQt5UW+AdPHI4HBz+S0vFtLA
 BCNrCU2B9tSyLTU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsMtVcegI28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBRbBKnibL1jrHLwOf3jNt5n06rMo4/zCQu1D8LIi3J
 DaFF9Iv287fEzjTcWIwZ1Q6xjIBH6wWDz8o/sukaSReoeMM4YDHRfzPGzGyfHQ0cn3KverLs
 qOBA==
X-Talos-CUID: 9a23:Pb6e5W9iezfWbS/fHXGVv1ceFv8iImCD936KDUiWGX1uE72eeHbFrQ==
X-Talos-MUID: 9a23:VEhhnAm8xpfR6/EgNJ0mdnpGHZdM44+nE3kMkJogoZa4BwdSZzuk2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Apr 2023 18:51:36 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
        by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 33CIpa4e017195
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:51:36 GMT
Received: from mail-dm3nam02lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by alln-opgw-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 18:51:36 +0000
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="5.98,339,1673913600"; 
   d="scan'";a="78294"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHTICZ9xT2ffnP29hyVlGTK1YI8MGOExQnT2JdU8vsbWUkSq0RZjrv5ZSV4AkueQBptunKefJVo8XpZ/vA0jrP4qzZ8Hac6sInXoGMODasWTZQqu8XlhFHr768l1DYgXXbIzRbaitJrShURoL2wChyAlRiPcgQDayx/FDiqKim9IiL6SXiGQxOeuNZpy2ojadMuoTnAGRhsAMBwfONuWmFBIl0DqKtskOtMOw7vwRWX45wjc3PMBLOCO4UnllDV1FMw+/JtTw0agKpYxaaJEHW+ylYyLlPhmOd0m+1fa8C/rmeitgIE6dGFie7rwnodDEmOcFPS+VsFLrFkqiJx+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQeq+XEUzVqNuU74RdQezQRFvfPb5pDZvmqlwL4xY7o=;
 b=LUhFS+nlt6UX9AwnARWEquUm9HMXFl0paNptefiSJSEDgcTpkcUrZDSjyvETqYDXNq8rr03oqJ+SabQnWCJhLeopa6/Cnuz8Xaq4riVJ3b9+jgeSF/HZS3ez4eH1K8it5r1S/m1Kcpp2hDlLzWdly3bbVtBcpfIcA3mRWC8rzcED7ZrOcSmm+3Xnzj2aZ/NMn5OR2Eby+iP0V+EAzJ7JNPcXoTqn06a4U8Bn92Re++JaFv9hf85cFlmWsZSJwNiOsxYMlocBqHm8gQEx49nreLqYCsEpoPWGx+S6qfJnl+LUO/Pbu2/HNFT02Oxpftmm2v/Uo4g1RiCZD8DdD7UmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQeq+XEUzVqNuU74RdQezQRFvfPb5pDZvmqlwL4xY7o=;
 b=AhOrzRRGG9K1GJGgvgwU0knwySI4kxI9rZrNXoL97wM92IenF0OleQDhm95KiiYAjik7xLICdUW4QNElA3Qwa75Z9/clEg2TgN8lZkrKJ5X/Y5h2fOz5HVdV4uK8dGMyZrMmrnzdC9449+Rl2uyECoMM3FGW+I24JwKmICaz8hg=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Wed, 12 Apr 2023 18:51:33 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 18:51:33 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Topic: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Index: AQHZaWqYW/PiGCKJbkGjA/VaWrFw5w==
Date:   Wed, 12 Apr 2023 18:51:33 +0000
Message-ID: <20230412185133.GV1391488@zorba>
References: <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230407160413.GD1391488@zorba>
 <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
 <20230410170915.GE1391488@zorba> <20230410175054.GF1391488@zorba>
 <c1319685-49cc-9326-f4f9-1190ff633450@linaro.org>
 <20230412150452.GQ1391488@zorba>
 <317c09a8-4df3-0a33-62b4-f5a496dfa0ca@linaro.org>
 <20230412170111.GS1391488@zorba>
 <b76b764d-79b2-2a83-33a4-b2bed5c25d69@linaro.org>
In-Reply-To: <b76b764d-79b2-2a83-33a4-b2bed5c25d69@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|DM4PR11MB5972:EE_
x-ms-office365-filtering-correlation-id: c09d0208-3910-4026-346b-08db3b86efaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBknxUx6NDX7Ac2cFV3svS6L7YnZ9nzegDVom3gUtbsZpsFfOUHqHpJmOCQ1F7/Exx4ANw01zAC36LiPi/JrBLjzScwxSLN/uf1qArpeqQehGrTqc23Oke+SFhuQYLlobqiG5UlIpXmD6u/4/9ZUP0SMZ9WLJNsao+s/k0zzSyZBKGlpOl3sVLH1wU8BNludBGaVPlcbw+j4lgWiouZ77OfLTcdr5XYV02jO0v7arxs357lSFbuwFSadW7SiN6KeL/82tyd2bzspB3+Bp+u0G5sTA7AzRaQ4XuPxfizVoHNo3J0Ih67E7YS6pdZSPZYidp0fvFjjV7QQJ9h5/CWu3GDUSdJYoWJZCOeUv6ZFuPfjplXwYFju42sohu8AR9bTR47P29h152rP0cdYtWl917VMh6shrnRn/IpAkxq8X0PBG2dmIPsmh6PNX1yNX5ePK1Oy1aYycgNMM6ylNBMF7jBRw8lahgaKMWq4dqzijTWrLDICODSY9hoJLm7vVAmsWBI0lZN1gokm+oxWQ239aJv+6EeGppnsr4LEsFr8tM3JwI1vNZuXUyXV6RZ7hiJ4/H3EigVgpT9XdfsUaVqayfm6wT2Ug7vdytjdS12OqN5kmkmTv+1U6yC9A1atVxGq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(33656002)(478600001)(71200400001)(6512007)(1076003)(316002)(5660300002)(26005)(9686003)(66556008)(6486002)(66446008)(6506007)(53546011)(186003)(2906002)(33716001)(76116006)(66946007)(4326008)(64756008)(41300700001)(66476007)(6916009)(8936002)(8676002)(54906003)(38100700002)(122000001)(83380400001)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fdkIwQWeNBMH+W8uxCPe3rqdE0I/J9pgFdDzFpRWeEHPLgaul7ryoRCRZAAt?=
 =?us-ascii?Q?HqZ/6nDOjGsNNLt3ipFdSugK/ctLC9Qp+pNUhNrabRbxB9LcJIg2JfoYygrO?=
 =?us-ascii?Q?nli1N6doTyOFF/NNwcOk4H8td/T1e6m+7odscftZzSIARjC0sBGYHIw5ykLp?=
 =?us-ascii?Q?fGQ+YxB8db+dVgEraMQaZti7Y2Di7RpllXHKGc0Js9Jlqp+0npa6HHWxfG0v?=
 =?us-ascii?Q?g96z2PYnMhzaPVgWPPrRSfBnwrBBg1/y7+MVqnvYcLsQSx7JuHflzeZI4t32?=
 =?us-ascii?Q?/N0JXjKay7QYw2iUkPnc9nvBw/Njt0bJg8l/ZCwNa/DSpA5a7kiuZH9rjF8A?=
 =?us-ascii?Q?og7FzhpXEcbsfogjIneZGO6bNOGLcdFXfxFNM37lc4jzpSMPDNPMWsjq9j50?=
 =?us-ascii?Q?dQ3T/QoCwLFNEfF9ewY4M+Y956qcbYLux8jtnICU969Efk1L3d8TmjRD9+82?=
 =?us-ascii?Q?4tI6yjlXZWG5hRLRVjkov5zGKZMs/Nxi+CI8ZfJ8dQe9tsCQt2kOTJfnALma?=
 =?us-ascii?Q?9iXMiF2mo/Ja6R0WsJrUqwS96rYYtHCjWmv2pn6o4cMgT/FWq6wIj+FeoXuf?=
 =?us-ascii?Q?iKLQDya7qvFvRftIPne9b8MfKcHcMfC51mboMKhjYCZxIU42JfaVskDZBlgl?=
 =?us-ascii?Q?sIVQkxiLvcebV4OSXF1Xq+y3jFj6Uh/9vmbKTinFvMQ3oamTWWQuxv1jp6PI?=
 =?us-ascii?Q?xQxZVTm7fFYFHsgEh6UZtuLAy+v74HQUPLFyuXAyTB7k1uMO9fJcgiAsk/m1?=
 =?us-ascii?Q?tTNQRKKaYRQHZ4UkOZ8U9NxYg9wHVnJVhj/pi8DwAPxX8kEkyMLINg12filk?=
 =?us-ascii?Q?0+8HCAIElZYEofN2xQgkevteWHeJng4zkAwIiA0RuwwobvhZ0PSwYxjrZy8N?=
 =?us-ascii?Q?WX7zoCAw5axS5SHQXdwFDf3ffXKEjr+tJAYLuNbl1SweWs/ZOe3ESIKsIXmv?=
 =?us-ascii?Q?Mon1HLZEirvFKwb3NtnM5nPKyjUxaWBm9rXUI37c3s9dxgLMK8DMT+cCFxTB?=
 =?us-ascii?Q?Y6/KXjMErK9c8TB2U9vdC6+Uf2S/Fa88etqQPV2mAlnETx7EYRJa9YJpHsgq?=
 =?us-ascii?Q?yl+iw+cDzGoPVFn+wMLOrGSPB0tbFaRC4Y+fUjSfFkrJFV6vYWDIedVqEsyS?=
 =?us-ascii?Q?VCkDnK5DXVtCrS+cw9IBvvPa3nzOSu9IDclbPfJM67MhK+GvYN1tYLTVajwZ?=
 =?us-ascii?Q?z1O1pUJq20rGv6DiZuP0LC+I3s0VxLjwv0FYtR7+zAlYgGhyJEJyjcFTgz7H?=
 =?us-ascii?Q?Zjhcdln+4Omf5wpLYGq2qXS5SVLUCFQ+bVEdHVXwiKL52ygmkvsryfJOo+Ta?=
 =?us-ascii?Q?uWXvxviWAuJUB4gS88bP2GO4VSmLOwC8c3tAt/GQw++kSgdIbudZBjItwY4+?=
 =?us-ascii?Q?KsVguzo/yJhj6hcWilvDIkzQTTlFdeRJ+fIE2K6xfvuI2giVbIljB0TH7D+G?=
 =?us-ascii?Q?YomOqtzaLA4ZftBCoN722tD0pMXq0xcYaXcdtWSes4rGeox12TN32TskHk9O?=
 =?us-ascii?Q?l4ifC3X7O+gjUAs3romYBQngdIvyNbz6v7/1/qp8DnE36ZR3mgNaVu6c9spn?=
 =?us-ascii?Q?esZ27okJGbl6xzfU4NPNXAEP37/KHhAD0DAf0YFxm2GbQ168Wb6Tev4hWMpJ?=
 =?us-ascii?Q?Tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06F7184CCE6F174CA816ACE5D87E2177@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d0208-3910-4026-346b-08db3b86efaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 18:51:33.5089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jg0a6EiuekSy7iMD1K+eMW/oaKujl0sBExZwKB43qgCCXnuFGKyrmPughxMGD84Zb21sTTq0LToeB3LgkWWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: alln-core-10.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 07:18:51PM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2023 19:01, Daniel Walker (danielwa) wrote:
> >>
> >> Yes, I understand this. But also how corporations work should not real=
ly
> >> be my problem. Especially that many of them were able to relicense eve=
n
> >> existing work, not mentioning new work. New work is piece of cake
> >> comparing with army of lawyers for existing, released work! Yet they
> >> could...
> >>
> >>>
> >>> What benefit does a BSD license hold for my employer over GPL v2 ?
> >>
> >> As BSD is permissive, it does not force the employer or its customer t=
o
> >> release the derived works to customers. GPL requires it (simplifying
> >> now). The employer and its customer have now choice. Dual license give=
s
> >> more choices. More choices is beneficial for the company or its
> >> customers, isn't?
> >=20
> > I don't think we derive value from this because Cisco only sells chips =
internally, not
> > externally.
>=20
> My answer was generic: dual license is beneficial for a company. Not
> specific: dual license is beneficial for Cisco. It might be the case you
> do not have benefits from dual license, but you also do not loose anythin=
g.
>=20
> Anyway, if SW release (for such chip) ever reaches external customer,
> then it matters. GPL compliance is for some lawyers huge pain and scary
> stuff, although should not be...
=20
GPL v2 has benefits in that the sources must be release. Cisco would lose t=
hat
under a BSD license.


> >>>
> >>> It's very likely that new bindings will be made by making a copy of o=
ther
> >>> bindings, then make modifications. If my company copied bindings whic=
h are GPL
> >>> v2, then we are required to honor the license of the prior binding
> >>> and that means we legally aren't allowed to relicense under BSD AFAIK=
.
> >>
> >> So copy some bindings which are dual-licensed... Since this is new wor=
k,
> >> you can do it.
> >=20
> > Writing the binding is already done. It's hard to go back.
>=20
> You can go back any time. Just "rm -fr" and write again. Since there is
> no other copyright holder than you (and/or your employer), you can do
> pretty much anything you wish with it.
>=20
> >=20
> > Is this dual license mandate documented someplace,
>=20
> Run checkpatch and do not send patches which fail.
=20
checkpatch actually contributes to the problem because it doesn't tell you =
not
to use GPL v2 bindings as a base for new bindings prior to making the bindi=
ng.
It tells you after you already made the binding.

> > because it seems like a
> > massive trap.
>=20
> Trap? Of what? Srsly... I heard GPL is a trap, but never about dual or
> BSD license.
=20
It's a trap because people may use GPL v2 bindings as a basis for new bindi=
ngs,
then get told later to relicense (either by checkpatch or you), something t=
hat
maybe difficult or not possible to do after the fact, or worse they relicen=
se in
violation of the GPL v2 license.

> >=20
> >>>
> >>> Also the documentation for the bindings here Documentation/devicetree=
/
> >>>
> >>> changesets.rst
> >>> dynamic-resolution-notes.rst
> >>> index.rst
> >>> kernel-api.rst
> >>> of_unittest.rst
> >>> overlay-notes.rst
> >>> usage-model.rst
> >>>
> >>> all the rst files are GPL v2 and not dual license.
> >>
> >> These are not bindings, so I do not understand your argument. What do
> >> you prove? That non-bindings do not have to use bindings rules? Yes,
> >> they are not bindings...
> >>
> >> Anyway, I feel like we are making some useless circles and wasting qui=
te
> >> a lot of energy on trivial rule. I tried to explain it, but if you do
> >> not like it - it's your choice. It will be a NAK.
> >=20
> > I'm pointing out that your dual license mandate has problems. Another i=
ssue is
> > you have dts files exclusively GPL v2,
>=20
> It's not a problem... but even if it was, why do you not want to
> dual-license them as well?
=20
It's not my choice.

> > and the dt bindings have dts fragments
> > which then have to be relicensed under BSD.
>=20
> Point me to the DTS fragment in this patch. I could not find it.

I'm saying generally many dts fragments are included inside the dt binding =
files
as examples. So examples can't be relicensed unless it's coming from the
original copyright holder.

> >=20
> > Are you as well going to nak our dts files? Or are those ok without bin=
dings ?
>=20
> 1. All compatibles must be documented, so if your DTS does not follow
> this rule I will NAK.
> 2. New platforms are supposed to have zero dtbs_check warnings, which is
> depending on above (1) plus enforces DT schema conversion.

So your response is yes, you will nak even dts files licensed correctly in =
order
to enforce your dual licensing scheme on dt bindings.

It's kind of unbelievable that the Linux community rejects even correctly
licensed device tree files.


Daniel=
