Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169FA6237DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiKJAAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:00:20 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D324C222B1;
        Wed,  9 Nov 2022 16:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1668038417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gyf/FLssXQKxZ/idok6jR2cwQI2ujLloadJC0dENO5s=;
  b=iYffWKK4Uxl2/QYgy7HzYxSgAukZU6kT/uNYMHIlMHszOJXonf0q3ixl
   FCXVYimU5+3emLup7F4P8Bo+9OJ5tsiDMHBsP2F94hIhHRvCnVo5jeXWq
   hZerN1R1BXHfLvkqy2pCIKPw494GH+45jxwniTOvoCGswopVJAXqXjyFE
   E=;
X-IronPort-RemoteIP: 104.47.58.100
X-IronPort-MID: 84953198
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:2Otp26Lzb/JMkrojFE+R5ZUlxSXFcZb7ZxGr2PjKsXjdYENS1mcBz
 2sWDT3UOPbeN2L0ftB/aYi180MC78TUzNVjGgBlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHv+kUrWs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPdwP9TlK6q4mlB5wRvPawjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5YHyYRr
 /oSGAxUSRu83cmW7u2XVsBj05FLwMnDZOvzu1lG5BSAVbMKZM6GRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dnpTGLlGSd05C0WDbRUvWMSd9YgQCzo
 WXe8n6iKhobKMae2XyO9XfEaurnzX+qBdlLRe3QGvhCx2+6mkIRNCYqZRjnuMX+hGShUvZgA
 hlBksYphe1onKCxdfHlVgKxpjiHoxsVQZxfDvUm4SmJy6zJ80CYAHQJSnhKb9lOnMUubTUu1
 1KPz5XlCFRHrLKRWVqZ97GJsSm1PykFa2MPDQcBTA0K5PH5rY0zhw6JRdFmeIa5h8P4XzH5x
 SuHqgA6hrMOnYgK0bm2+RbMhDfEjoiZECY26x/RU2bj6Rl2DKalf4WA+0nH6uwGJ4GcJnGbt
 XYNlsy27+0UC5yJ0iuXT40lBLi36vKtLTbDx1V9d7Eh+zmi/HOvcKhK7T1+LVsvOcEBERftY
 UnOqUZS6YVVMX+Cc6B6ecSyBt4swKymEs7qPtjQb9xTct1pcSeZ8yx0I02dxWbglA4ri65XE
 ZuSd8ehCTABD6lrwD2wb+Mc16I7gCE42W7XA5v8ynyP2LyCY3iUTvEKN16DfKY446eJuwTc6
 P5bNs2X21NeVvHzZm/c9ot7ELwRBX0yBJSzp8kJcOeGe1JiADt4U6eXxq49cYt4magTjv3P4
 ny2Rk5fzhz4mGHDLgKJLHtkbdsDQKpCkJ7yBgR0VX7A5pTpSd/HAHs3H3fvQYQayQ==
IronPort-HdrOrdr: A9a23:S4/M/q/EiXFchfecOZJuk+F7db1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQodcdDpAtjifZtFnaQFrLX5To3SJjUO31HYYL2KjLGSiQEIfheTygcz79
 YGT0ETMrzN5B1B/L7HCWqDYpkdKbu8gcaVbI7lph8DIz2CKZsQljuRYTzrcHGeMTM2YabRY6
 Dsg/avyQDBRV0nKuCAQlUVVenKoNPG0Lj8ZwQdOhIh4A6SyRu19b/TCXGjr1YjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y+FEGNeHhqEuW3XRY0eTFcdcso+5zXUISdKUmRIXeR
 730lAd1vFImjHsl6eO0F3QMkfboW8TAjTZuCKlaDPY0LDErXQBeoR8bMtiA2XkAwBLhqAC7I
 tbm22erJZZFhXGgWD04MXJTQhjkg6urWMlivN7tQ0XbWIyUs4nkWUkxjIiLL4QWCbhrIw3Gu
 hnC8/RoP5QbFOBdnjc+m1i2salUHg/FgqPBhFqgL3f7xFG2HRii0cIzs0WmXkNsJo7Vplf/u
 zBdqBljqtHQMMaZb90QO0BXcy0AGrQRg+kChPbHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33I
 /MVVtJ3FRCD34Gyff+qaGj3iq9M1lVBw6du/22z6IJyoHUVf7sLTCJTkwono+pv+gfa/erKc
 qOBA==
X-IronPort-AV: E=Sophos;i="5.96,152,1665460800"; 
   d="scan'208";a="84953198"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 19:00:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogsbxMI/hVU4Ft+wOqC0sZVnM8AnJ3Z8z9Dg3tZXQzOFjB2f6fzZzUIMK0D+iOhKV04lgAe/qnW4ylxw9RUdgWO4RAYexX1SN90QZRnAu6ezk2NQAIPjdBx76uVsERYszmE4ntB8rjQpq5ha3V6gWKFR9A/v6R746Q7eficbBItYlDpTpA5Fwlyr7xLDe4YGzAY/wTKAf/yU9YntBg2NdqMcWO6t0vGwNuumaunJVnbvu5P76PaFVAjMooYcs+eILzJbVhBrHQ+crlSfvtp31qxjYBgrbodlwMwIYBwNhf8Yn2XlRX46na57CLDz6NeYGBDRr/loDR+WWv9D2UP9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyf/FLssXQKxZ/idok6jR2cwQI2ujLloadJC0dENO5s=;
 b=ShkK88S6/gSa8btRDfeUh98RDUjuiD6KSvWHpXoD4VBFIrBkivVlJgzp6zl96mHCPmQ/mRznswupNC0aN6gaYe3YmPKZvwSVq9O5zOUJiOwdnnIdGo+uf8/92sUn6s6C3EMwID972R5nqjRJwkN+16RYAOIkBOisoP23xguYkmI0yOjh6d+ygCt2I20i0oSKIGXZjzfn8jOcQr6bioM5VQ6xV1qCR+4QdGuvmLlPlblez1wHUH+ImUasKfZuztEkkUv4Mfu99h9erRWITOgAce/X8hza33aFYpnrv1VRjoB6zRrqXnXG/ri+PaCCb7NGP4AVsFg4pCiOjARq59XOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyf/FLssXQKxZ/idok6jR2cwQI2ujLloadJC0dENO5s=;
 b=HoBgDsr48M7GR/bN4GvECwZTK7PtmgbZiWBq8OzEwZIUd1C5+DIFWBZQZ1fL0J2kqww3naPGHJBMnWDl8Fw5mB5BJoyinR0BofgQNUlCwDyv3/6ce94fyRK9G+LrE0g+CIFTu0LOT18i5CrRA/5bcDkSaQAPKqIEmsn1Z01noKk=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 00:00:12 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 00:00:11 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        "antonio.gomez.iglesias@linux.intel.com" 
        <antonio.gomez.iglesias@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Thread-Topic: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Thread-Index: AQHYxwEcA7jcOm8DjU6Z/y36WK/AeK41uOuAgABCaICAAAVEAIAAGqmAgAEakwCAAGr4gA==
Date:   Thu, 10 Nov 2022 00:00:11 +0000
Message-ID: <bee087ff-d7f7-4f6a-4c43-8c91fdec043a@citrix.com>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <Y2qlyfRKgIc4KVcx@zn.tnic> <20221108225141.aikng7veemp25p62@desk>
 <Y2rh6FN+gbD6Vbzj@zn.tnic> <1ee02d57-21a7-b18e-6cf9-0667445a6fb3@citrix.com>
 <20221109173720.4ovtb2ao3vuuge43@desk>
In-Reply-To: <20221109173720.4ovtb2ao3vuuge43@desk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|PH0PR03MB5847:EE_
x-ms-office365-filtering-correlation-id: a2f32a7e-03a2-4114-220c-08dac2ae89ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4gHKfZDbFOEk9ZHKN3Gk0OJmxZ7zJS+UEg4mL7UDf+TGXziFpPlgtk4yWVKMJ4Ec9cwyg8JZNtnaR6hbHuTKTU+UuwxMGI//Yyz/XlOCsIIluwWdXwRdlV2HoiIJI7GsQmhSPu0jp4wQsscCYMAtH3wxrIUg/or45cgXKC/zjsCun+Czeqa+Un5wBXEQsMQXc1JnT/FRmU1f/PN1DIHzBR2CZzJ5LJ5F1uZp/LYdxE+wjhZpm2V10y101VujD7xI6rHtEDjuRa9gv1jAJDpix6s+iuyNk4sstMggILkqQe5H7jLwkc2GY5Hx5rXq9meIFdnK43rPeT3nLdsr12tK83POSed/LghP5ytxRiYmUJ5FFSw++jw3tR8VpYs7B8aKS0iuN7tACoMoaIXue6if5KFhWd6fHa6DlUCvxZP4oOYSLeG10L/L+JJS8qrGEtm2Kf5GFKXTglOom/cViR6hR5zKEQG/oH4M2/KcBKgrnSDvWNkJlZL1uhRBw0Dz/gzXeyZW+wJp4n6+iCZoma/55L0s7qPCyimsqzwvXx0OEDfiisXVYyTDRPsm8etwXLVYiu9y83Q9uR2pmkBOfS/hOLY9DUnm+VvcUGyT1Z+8Kcs1yIcJXzYJQbJ/7iHlu5O/AUhO2kULBTlAmSXmPYOim1BQN/RY3m0LnVlg7u+/qNsRGmQq5pST3MdzBDh51idk8a3slcG1k21q+d7AKvjL1RPp8VRpJG61VsOx5y8hDkZwpvwDL8W3mnwQQZANxSttKAFpvB0m1u289cxYs1D4Tsa3tLZwE3XOdft0y0VRfJ4l1x76EqRp+mbSmHYzDWPgL+wWdcy9/frRMZsmrpVEWE7GW3ckCzl7h0pzh8xkY0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(31686004)(38070700005)(82960400001)(478600001)(6512007)(122000001)(36756003)(86362001)(2906002)(31696002)(186003)(41300700001)(7416002)(5660300002)(83380400001)(38100700002)(53546011)(76116006)(6916009)(71200400001)(66556008)(66476007)(66946007)(54906003)(6506007)(26005)(316002)(64756008)(66446008)(8936002)(6486002)(4326008)(966005)(2616005)(91956017)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1MyV0ZCdlg5VWpsZEYxc2ZBV1BWT0g1L1hvWEpiYUlYWGhmRXBoREVWNnZy?=
 =?utf-8?B?WWcyS1VxaEV0QU1vSUV1Q0o2RVZkOXJSdzJ2SFBHc1JZZWhKUWN6VGY4Q0tG?=
 =?utf-8?B?eVJDUUJ6WEdoNllUNVc5Q0FJeGkvVnQ0Q1lXN3VsSFE4RmxkTDhhYUJZb1hL?=
 =?utf-8?B?Tkk2ZVpoeURLTTNmYldkbXlCcjk1UkVjaFZTWmNoT3BIZHhEekd3M1UyWHRB?=
 =?utf-8?B?eDVpMG1ubkdyZ0hIQnRuSGF4clN6bDhMamIxQXhtcVVBeDRjblpubHRDSkhn?=
 =?utf-8?B?QzJMUnlBd3MzdkhObGcyeUpOY09SOVcrOTR1WU9mNS9UZHUybjNYeGpLRGpN?=
 =?utf-8?B?MlpaL3NKR29Da2NIUTIzRkV6bXN0eENJcDN5ZWw5cHN4eTRZZHliNkhZdDUy?=
 =?utf-8?B?OFFMWmErNE5JY0UvK1NuUlh4YzE5anA2Ym1hb0lZNE5EZnlFMmlEanJDU2ln?=
 =?utf-8?B?ZnZmUU0yOG5yQkMvOGMvY2lWUXhJWlMyYVBiTnRrYTR5UXBzRVBuWHdMbFcv?=
 =?utf-8?B?RVJQeGlpcVczVCtRaU9PU3Z5aVdITTI3dktOeUU0VjdnY0svQS9TUElzUCsw?=
 =?utf-8?B?N3Juc3RZL1NtWmJaWGNhSE9KY1l5bzI5ZmhNRFJZd2t5YnlvRnRBTVpvR3hO?=
 =?utf-8?B?Z3BtNjhVaDdDcU4wQ0s3eXRtVGVIRWJLc1U1RnZ2dENZM0ExYmtLZFoxdlhS?=
 =?utf-8?B?aXN3b1loSUs5Zi95QUZoejZ5V3JOR0JodU9KelNxNHplaUszeUEwaHh4VWxT?=
 =?utf-8?B?cUQreHhXaGFGclYvRlR5UEkvcnF0OXpZSnpIMTY4OXI5MU5nbzNyREhvSlF4?=
 =?utf-8?B?aXR2Zk5aUFVVSExwNEJYVzhZcFI4Wm9VdzBBMFVoVFJhcHcxOVJaMTA4K0hp?=
 =?utf-8?B?Y1RWRFVrTkkyN2oyNk8zdkI3YVJYTEd2MFZURlFXYkwveHJUR3QrMnZCU2pp?=
 =?utf-8?B?SFczdG9nb3hrejJ3QTlpN1FERmNZSm5ma3lWbHI2SzdDS2k5T1lFQ05VejhP?=
 =?utf-8?B?QkM1WXVPUm9zQUQ1MzAxNU5FenhxME5OM3hBbFN1U0FPaFpzR3lSc3BZTXJP?=
 =?utf-8?B?aUozUFQvdUtmTFFmTWVKK041elRLbmJSUVFvbElBY0duTVBpQjJJNWMwb3Jo?=
 =?utf-8?B?bkg1cmdNalVwdjFLai8vcDVwTFpIOVBmOVpGRE5ZTGJxbG43OHhoQVA1cnF3?=
 =?utf-8?B?MitQenUyL3dWclFQTmRhUHI5Y1UzTzFwR0xFektWM3VyckdGR0V2aXVqQlFv?=
 =?utf-8?B?ekJWMTl5djJNZ1E1TEN2VVJnL3VSbWovT3V0ZFZrdzhSQ0NGbHNRYUUxS2RJ?=
 =?utf-8?B?ZDZ5d09wWXJSTHJEczFFc0Nadk1Vc1QwME9oQnVjd2ZZcDB2QzR2S2g3bkpV?=
 =?utf-8?B?RXBYUVpSbUNmU1lHOTVxS2NHakllN2J2U2ZGVGc5VFEyS0Y2VXBlZnRJRnpp?=
 =?utf-8?B?eVNNV0VoMHBrYWdmZmwxY3dwdmZhUUNMVnY3Z25WQWdocm5NTTYwb0xzS3Jo?=
 =?utf-8?B?MDV5S2ZTTW45dUNkOGxjakI5SFdHeUhWd2ZXb1N3UUtNOU1aMmU3eXhxRWZY?=
 =?utf-8?B?bGxMeTMzRzM5SjFWSkdtR0hVZlpsL3FoaEIvV1B3Y21lbmkxWUQ3TXVEbXZq?=
 =?utf-8?B?RllsaEZNc1htWWIxZGEzSEltL1hxQ0JldjEycTdZU0ZiYmhwVUN4V2lXaTV4?=
 =?utf-8?B?ZDU1azJDUFFPYUZra2xjcjRXRFRROHFKNkJwSXJnaHQ4QVFpWjZ2dkZnYkFO?=
 =?utf-8?B?c3YzcWdFczMyWmQ2Q0YrRDYwYkNvVjV4OGZmelh0N3BHZTlWSXd2M0I4M0pv?=
 =?utf-8?B?elRYY3Vlb3FuRmVRRWUxWnVXOXQ4cFh0ZXZjWHpyU2Y1UTlGbmRNYXhJL3Aw?=
 =?utf-8?B?M003RXdoQWNFVWhHZkdUN1M0Z3g2TXZGNmF2Q2R2T1ZUTzkxWCtmL2lQTldU?=
 =?utf-8?B?SnhOMmpHaDB2UmF1ZGRnMSsyZUhBMC90MzdRME9Oa2Q2NGdSaFo0bE5MZkta?=
 =?utf-8?B?YTR4SU5rRDd4VkxXQmxTSnFsb0RzSTBQWk01VDc4NXNRYnd0d1NwdDZPSERF?=
 =?utf-8?B?QmI0WGFyZW9tM3VkVkFnSC9Ba3E5SG5Zd2hFN1cxVzRrZTlUYVVKMTF1dzBw?=
 =?utf-8?Q?O2CQKSx7OVYBgmo9Qm762b0QQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E703D50641D844289A588092119B38C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f32a7e-03a2-4114-220c-08dac2ae89ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 00:00:11.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4ETK/G36TtB/TIwDxkTI32Svsed+3wnw/aGa3+6tJw666t6wjEX6+XsL+MgTLflJh7gjHIrJ8hJ5LqX/HMafKJ7WWueG9LaDDT9N3Pp51o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMTEvMjAyMiAxNzozNywgUGF3YW4gR3VwdGEgd3JvdGU6DQo+IE9uIFdlZCwgTm92IDA5
LCAyMDIyIGF0IDEyOjQ1OjU4QU0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBPbiAw
OC8xMS8yMDIyIDIzOjEwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4gT24gVHVlLCBOb3Yg
MDgsIDIwMjIgYXQgMDI6NTE6NDFQTSAtMDgwMCwgUGF3YW4gR3VwdGEgd3JvdGU6DQo+Pj4+IExv
b2tpbmcgYXQgYnNwX2luaXRfYW1kKCkgdGhpcyBmZWF0dXJlIGJpdCB3aWxsIG9ubHkgYmUgc2V0
IG9uIEFNRA0KPj4+PiBmYW1pbGllcyAweDE1LTB4MTcuIEFuZHJldyBtZW50aW9uZWQgdGhhdCB0
aGUgTVNSIExTX0NGRyBpcyBwcmVzZW50IG9uDQo+Pj4+IEFNRCBmYW1pbHkgPj0gMHgxMCAmJiBm
YW1pbHkgPD0gMHgxOC4NCj4+PiBEbyB5b3UgbmVlZCB0byBzYXZlIHRoYXQgTVNSIG9uIHRob3Nl
IGZhbWlsaWVzPw0KPj4+DQo+Pj4gT3IgZG8gMHgxNS0weDE4IHN1ZmZpY2U/DQo+Pj4NCj4+PiBZ
ZXMsIDB4MTggYmVjYXVzZSB0aGF0J3MgSHlnb24gYW5kIHRoYXQgZG9lcyBpdHMgb3duIGRldGVj
dGlvbi4NCj4+Pg0KPj4+IFNvLCBkbyB5b3UgbmVlZCB0byBzYXZlIGl0IG9uIGZhbWlsaWVzIDB4
MTAtMHgxND8NCj4+DQo+PiBodHRwczovL3d3dy5hbWQuY29tL3N5c3RlbS9maWxlcy9kb2N1bWVu
dHMvc29mdHdhcmUtdGVjaG5pcXVlcy1mb3ItbWFuYWdpbmctc3BlY3VsYXRpb24ucGRmwqANCj4+
DQo+PiBNaXRpZ2F0aW9uIEctMi4NCj4+DQo+PiBUaGUgTVNSIGV4aXN0cyBvbiBGYW0gMTAvMTIv
MTQvMTUvMTYvMTcsIGFuZCBpbiBhbGwgY2FzZXMgdGhlDQo+PiBMRkVOQ0VfRElTUEFUQ0ggYml0
IHdhbnRzIHNldHRpbmcgaWYgbm90IGFscmVhZHkgc2V0Lg0KPg0KPiBJc24ndCB0aGF0IGEgZGlm
ZmVyZW50IE1TUjoNCj4NCj4gwqAgI2RlZmluZSBNU1JfQU1ENjRfTFNfQ0ZHwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDB4YzAwMTEwMjANCj4NCj4gwqAgI2RlZmluZSBNU1JfRjEwSF9E
RUNGR8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhjMDAxMTAyOQ0KPiDCoCAj
ZGVmaW5lIE1TUl9GMTBIX0RFQ0ZHX0xGRU5DRV9TRVJJQUxJWkVfQklUwqDCoMKgwqAgMQ0KDQpP
aCB5ZXMuwqAgWW91J3JlIGFic29sdXRlbHkgY29ycmVjdC7CoCBJIGRpZCBnZXQgdGhlIHR3byBt
aXhlZCB1cC4NCg0KRnVubmlseSBlbm91Z2gsIHRoZSBsZmVuY2UgZGlzcGF0Y2ggcHJvcGVydGll
cyBhcmUgaW4gdGhlIERlY29kZS9FeGVjdXRlDQpjb25maWd1cmF0aW9uIE1TUiwgd2hpbGUgdGhl
IGtub2IgZm9yIFNwZWN1bGF0aXZlIFN0b3JlIEJ5cGFzcyBpcyBpbiB0aGUNCkxvYWQvU3RvcmUg
Y29uZmlndXJhdGlvbiBNU1IuDQoNCj4gTG9va3MgbGlrZSB3ZSBuZWVkIHRvIHJlc3RvcmUgdGhp
cyBNU1IgdG9vLCBhbmQgd2UgY2FuIHVzZSBleGlzdGluZw0KPiBYODZfRkVBVFVSRV9YTU0yIHRv
IGVudW1lcmF0ZSBpdC4NCg0KSW4gdGhpcyBjYXNlLCBJIHdvdWxkbid0IHNheSBzby4NCg0KRm9y
IGxmZW5jZSBkaXNwYXRjaCwgdGhlcmUgYXJlIG5vIHVzZXIgb3B0aW9ucy7CoCBUaGUgYml0IG5l
ZWRzIHNldHRpbmcsDQphbmQgeW91IGRvbid0IGNhcmUgYWJvdXQgcHJlc2VydmluZyB0aGUgb2xk
IHZhbHVlLg0KDQpJbiBmYWN0LCBBTUQgcmV0cm9hY3RpdmVseSBkZWNsYXJlZCBiaXQgaXMgYXJj
aGl0ZWN0dXJhbCwgYW5kIGl0J3MNCmZpeGVkLTEgaW4gRmFtMTloIGFuZCBsYXRlciBzbyB5b3Ug
Y2FuJ3QgZXZlbiBhY2NpZGVudGFsbHkgdHVybiBvZmYNCnNwZWN1bGF0aW9uIHByb3RlY3Rpb25z
LsKgIChBY3R1YWxseSwgc28gYSBtYWxpY2lvdXMgaHlwZXJ2aXNvciBjYW4ndA0KdHVybiBvZmYg
c3BlY3VsYXRpb24gcHJvdGVjdGlvbnMgYmVoaW5kIHRoZSBiYWNrIG9mIGFuIGVuY3J5cHRlZCBW
TS4pDQoNCj4NCj4gSWYgU1NCRCBpcyB0aGUgb25seSByZWFzb24gdG8gcmVzdG9yZSBNU1JfQU1E
NjRfTFNfQ0ZHIHRoZW4gd2Ugc2hvdWxkIGJlDQo+IGFibGUgdG8gdXNlIFg4Nl9GRUFUVVJFX0xT
X0NGR19TU0JEIGZvciBlbnVtZXJhdGlvbi4NCg0KWWVhaCwgYWx0aG91Z2ggaXQgb2NjdXJzIHRv
IG1lIHRoYXQgeW91IHByb2JhYmx5IGRvbid0IHdhbnQgdG8NCnNhdmUvcmVzdG9yZSB0aGUgd2hv
bGUgTVNSLsKgIEl0J3MgZnVsbCBvZiBvdGhlciB0aGluZ3Mgd2hpY2ggd2FudCB0bw0Kc3RheSBp
biB0aGVpciBjdXJyZW50IGNvbmZpZ3VyYXRpb24uDQoNCn5BbmRyZXcNCg==
