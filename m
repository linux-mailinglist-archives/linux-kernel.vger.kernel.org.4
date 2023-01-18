Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E8671F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjAROMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjAROMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:12:20 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAA14689
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1674050012;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IaoY67JsHFpV6s+3TV4anSJ6LQ9em/1iMVNn2PRymjA=;
  b=F0L+2fXXgwocTH0vbQ70u3EGdVe/JZ42peiR5RBWGxOK1e6t7bjCvGOF
   1Xj07CLDpkq3D3RoVQdVWyd4TVQ1w80CcDqGSpSrg3fBy9g9oXIh3U/jH
   DW5Yyc1tvzpr7xUDNvwKSKGG4LLwfu9s5WCBZNoJAcAgIp5LeRE8XG6EO
   4=;
X-IronPort-RemoteIP: 104.47.73.40
X-IronPort-MID: 93589175
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:2oPCqarf2jjsHIJZIIpb4NKgmR9eBmKYZBIvgKrLsJaIsI4StFCzt
 garIBmFOPyNa2SheNtxbt7i80MF7JHRndRlTAptqng3FCgap5uZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpAFc+E0/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WxwUmAWP6gR5weHzilNUPrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXACJQdAyli/Do+p/hRutQj/seB463DIxK7xmMzRmBZRonabbqZv2WoPN9gnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3j+OrbIK9lt+iHK25mm6xo
 G7c8nu/KRYdLNGFkhKO8262h/+JliT+MG4XPOzjq6472QLOroAVIDMuWmXio9Wzs0+jdI9We
 2wb3ykN7qdnoSRHSfG4BXVUukWssgEZRIB4Eus08giBx6PYpQGDCQAsTDFbb8c9nNQrXjFs3
 ViM9/vyHiBmurCRTXOb95+XoCm0NCxTKnUNDQcUQA1A79T9rYUbihPUUs0lAKOzlsfyGzz73
 3aNtidWr7ESi9Mbkqa251bKhxqyqZXTCA04/APaWiSi9AwRTJKqY5yA7Vnd8OpaK4CYXh+Ns
 RAsg8GD6MgeAJfLkzaCKNjhB5ms7veBdTHZ31hmGsF98yz3oyL7O4dN/Dt5OUFldN4efiPka
 1PSvgUX44JPOHytbul8ZIfZ59kW8JUM3O/NDpj8BueiqLArHONb1EmCvXKt4l0=
IronPort-HdrOrdr: A9a23:NY+LAandlJEhq/hollOUjySyqajpDfI73DAbv31ZSRFFG/Fw9v
 re/8jzsCWe4gr5N0tQ++xoR5PwJE80maQZ3WBzB9eftWvd1ldARbsKhbcKpQeNJ8SUzI9gPM
 lbHJSWAeeAaWRHsQ==
X-IronPort-AV: E=Sophos;i="5.97,226,1669093200"; 
   d="scan'208";a="93589175"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 08:53:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ9Wv/VcEnb3xJTqUCCOdFReAQhyhHKQhteYE7x2tRXX7ozIm1dgjmTJD1oFRi+fL7HBnXtSRrjTvaRrqLv7f3NO7KReY/LfeaCxKbP+Ko+W97X4/L8Kq08qakN5gPE5oLrxun7aFICWP0NYHbUy+K1wxkid/sQIb26p0yySD2R01eRo9+CJTMAUSjMi254v+eClDiltjQ0GVJfFjnzrAAvBnQjv87lKmhvnRdvSwVf1S4bfK6p5bH1Le4qLx8fBCtef78Bh0JpEYpGrWQ6OzXRByUezn2uU/O4bkAQdlk1XmjQAX+ANKe1iC8n5v7tP0p6FNfa7U1p7SIpKELXDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaoY67JsHFpV6s+3TV4anSJ6LQ9em/1iMVNn2PRymjA=;
 b=miWl7DDHmPt0eafQd5DRVNnmIqqe32OBVeaa/WX+AO4vEAiPl8amy1r72NI9/x/XHMq/KQAWNCPqpf+zVPkgJqp1N6/TD0uRprgEYgGpUxFgjTRYeh/ULKbZWFNyvXjLBh5eOOTPAxSKh1qvqTrEe5SRQjn+owm22fTJNO2Z1oLgzMaXZFcKPTT5dygYrwM1ZvYwb2fuO2lpRnIzuCOyKEqj8xIZPFsO5lDVR3wOThiuATAjFp7pSTOhyfhGjVeUEQwbwFhTBiHgkUdA0z0xj1lyycHKbxIFzk8ulH/BCaSNGyNsm5YbyvsWfOalaW8oIayBLmFjRSfMBb/Fz+jvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaoY67JsHFpV6s+3TV4anSJ6LQ9em/1iMVNn2PRymjA=;
 b=rleNA5yMlXKgufGpDoQN0n8fiqV6ZJ/I96hrhjOTrWTqE4p73PjhMFOvJrWA1K4zKin78xrMRcP8k0PxGiPQGEPfoNI92Gj6ZbDazhGPuuR+e2XLWoFtTletCkK0uDNkoE3m+cE1UlnAH5GXQX81S491k8fjxIY6hnydHRaLxcY=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MN2PR03MB5054.namprd03.prod.outlook.com (2603:10b6:208:1ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 13:53:28 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 13:53:28 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Durrant <paul@xen.org>
Subject: Re: [PATCH] xen: Allow platform PCI interrupt to be shared
Thread-Topic: [PATCH] xen: Allow platform PCI interrupt to be shared
Thread-Index: AQHZKze3xTuOiK3Or0K7Zn5gBYHKJq6kMguA
Date:   Wed, 18 Jan 2023 13:53:28 +0000
Message-ID: <e0b75988-bee6-e0c7-0dda-86e1e973ba74@citrix.com>
References: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>
In-Reply-To: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|MN2PR03MB5054:EE_
x-ms-office365-filtering-correlation-id: 703c0cc5-00de-490e-b2bc-08daf95b6080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOC0XwWswix57sziGHFrDlwBSjX5zSdz4nwkMv0UbEImrXHgqDmVq+ysl/Dj34+iFN+jeo93y4NeaeeJZL1h2fszswE7kiGreb8AeEK3XfUn6C9uVPbW9IXNNHl3SAG1Rc7c7CDx8pJKCyvT2wTFA/urxbSZwRzArsFcnh2TPQ0Socmlmt7wmE9SWL4M0X+4627ezPn7Rz7rCT7DqCmqZkwqlrYOlf+ZGxJg3O7BOIFySCoMZ6MxwRM82guAKux3GvVGa9WykOJMfkMxzTYvVQRz1ziDLaVzQQhcm9uw890z6aA6d0VAtuBVfmQvdmK+yvDgpWdnQmueNTk6MsngdRyG00sYfTuz4b1KJFuHgkFmkpSRuNsLSojOtpfhpYdSCUtVn5xjoEVGqYUQkt64xcaGWXQGHztKyTeIahC0RVTDxcpg7O1TcD+2mBpeWNqpsrdu5d4VOzDz+ZO73kldX4hb42amBoX+lSyKKuPrQr9vDWFD5SYmYzB7EJWWOKd0h6Ocp1qXZNewwnGM60U+GISppnK75xnc+AGZ91jgrcdQBHlSRkKVrf9La6jpA5oAUF8iocW4ob7b32rkBwHIbTTtg0SuOh4DBHZCsV6qhyooyN1xSDZfqS9Ke0HjpSOvYozxMfWHuk+JfH1CS1Qd2YWnhscbArNXhlBZJMCjoiGuF76VG8mTfQCKy5zU7b4AQY2GxvnGPtvQW6urKm1XoKfTKOqblb8Kb96XPno+lN5TLtccsJZBL9quvrl7BXPI2juN1OG4GJfhL7A3M9/kvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(31686004)(36756003)(8676002)(38070700005)(86362001)(8936002)(66476007)(66446008)(66946007)(66556008)(76116006)(4744005)(31696002)(2906002)(5660300002)(38100700002)(91956017)(82960400001)(83380400001)(64756008)(122000001)(478600001)(316002)(6486002)(71200400001)(110136005)(41300700001)(53546011)(2616005)(26005)(6506007)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZEcjcxeTFZUVAvK3owYi9idHFiZWhtSys4NnM1cGxnVXN1b3M2aHpRemxm?=
 =?utf-8?B?ZXYyY1Mvb3ZvV3BPb056RlJlMUtnTkJKbk5xb3JTZ3kwQXUxTm5aUEd4TVpO?=
 =?utf-8?B?Tkg3SkkyQ2pjSVR0RXdxdnhOM1E1eCtCRmoycDAvREJ5a2w0bEVPNWdrTkd1?=
 =?utf-8?B?RDArSUlpTGlvQ2FKcW5XNDEyTzNwUlVhRElyU3BXUUdnanE5TFdMVUVvNkt2?=
 =?utf-8?B?Q0JQRFdmS1pwMnZrdFhSZkNYcUhVb0hRM0E0VlpGTUJ0YnRzY3hRbWJPb0lo?=
 =?utf-8?B?c04yVkxpdU9XeTJTRUIvaVZ6MkFZWUdiTEVoQnp6TEpQeXpyU3crQTNRYmhZ?=
 =?utf-8?B?cVEyV1lBemhQaVNPTWNJdldYYkl0dTFnL3R4d3FoN2czdzM4eEkwU3VRblNk?=
 =?utf-8?B?M3R3eDBZQVQ4Q2Zhc0pFbmxLa1ppK0JRUS95YjM1THliYVhEdHNiZEdmRnpr?=
 =?utf-8?B?MHJZaWFFZTM5Y0lOWlFGUFBROWdCdjRoZzNRWEJzUk1kZ29aeHdjVGxsWUFm?=
 =?utf-8?B?UDFKa250VmMyUWhhOGlIRDJOdEQyQ1c3cGdhT0xzM21pVVVPTVV5KzdmbklN?=
 =?utf-8?B?WHdzYTA2NHFzbUxwRUZRQkZieG5VUGNLLy9vQUJYeDlMQk1tWURFVlh3Umkr?=
 =?utf-8?B?T2tnM2dIQzR4OEhPMTBkUDVDcTVncVRwVGJ5RUFtay9Bb042b25iVDZqYXBC?=
 =?utf-8?B?VXRvV2tyN3BubkNsQmRYbFUzVmdOM0ZJMjZuZC9xOFB6eUpyaGExREpnZ0FT?=
 =?utf-8?B?UVE0c0hvNk1DY2kvVzBVSmx6SWRoZEQraFQvMnZGUUdER05nRzlYMlBuWWlN?=
 =?utf-8?B?RHp3UVU3K1dHblVqbGNNclhlM3RGWlBNQ0F1MmZpL1I2b1hFWjljVThDbjF5?=
 =?utf-8?B?QnNybk9PTjF1M0llZzFLcjhNS2ZtUEJGOGo1VEpLb3Q3eS9ON2xGM3NadnFV?=
 =?utf-8?B?TEk1bkhIV0dsQ0thYzE1eTJXUE5KbVN4bUF6dlhlcVVlWlpNelBNT2VHRGhh?=
 =?utf-8?B?TnhPYy9qZ0lJcWtYbGpMZ3NKaXR3N3BNanRRelZCdS9qcmJPTTBCV1ZJTXpq?=
 =?utf-8?B?K0hZL01PZjZMRmsxV1hRQ1pYNTk0QWZneHQxSkJjYmpNbHdBUTNtNGV6QUdh?=
 =?utf-8?B?QjFEdVYwY1dPVGdvNTUxRmNmWGtrR0cxdTJzT3VKT28vTVVaOUp3Q1NIeHNh?=
 =?utf-8?B?RXVaeU1MZzhHNEVhc2d0Y0l6dWphbWVUa3Jpb3JGR1pVZVcvQmRqVVoySmFF?=
 =?utf-8?B?L2hLYVhjTEJGWHZGOXpJaEpDQ3ZkLzFwdk1WRGpNU2lBWmpwbmNwMmpUK3J1?=
 =?utf-8?B?UU1tZzVQYzBDRXNxazZNcndJbDdCUG1iQVI0NDBBek04Rm1xMUVrUmhDYTZ1?=
 =?utf-8?B?VVZXd2hyQ3VjUWwyN2xDdVhlYzhSS2VqM3VFZVZBcTRzTjJweWp3dS9saitN?=
 =?utf-8?B?clNwQ1VCeHRYQnNnWVMzbldOVXQ3WTgwa1hHVkxGNE9seldEeXdFejVLVHZN?=
 =?utf-8?B?aGlhdEM4UDh2YXRXbWl0eGN6N1RUTFN3VmVXeVZTbFJpRHBGNnE3WExWdDY5?=
 =?utf-8?B?b0VGYTdtZWp5SCtxelBJWUZjSzdpNUNQSU5DdWs5VWgrNmlkaEZJai9sVHRh?=
 =?utf-8?B?MDE3NWg0RSswQkttM0FsbFBpN2xJOGhVSkVsS2xoRjFCSmRYeEpuWnQvQy9q?=
 =?utf-8?B?NWVqZ2hOQUlXaUg2NWlNcllxYXhJQ3RsQUdRWEN4Si9YNWtHOVFHbDMwK2p1?=
 =?utf-8?B?TW1yaE5Nem1aZEF2Z0JjVU5jcm5pYkRzaHpENHB3T0ZDZWdnQ2pyZXQrZjl2?=
 =?utf-8?B?U0xzRzdac0NJcDdXb0JLTDVzNXdmaHhwWFNXVGpsZFUrZHkvWlFidnVCT2Vz?=
 =?utf-8?B?YVNHOThaNC9seG1Hb0RSUHAxeE02SDVocDRidFpLeEZpTHNpcDhTa05TNkoz?=
 =?utf-8?B?SURwK2xWaWEzRFJkVlFmOEhEMEJMZnlvdTVUSEFQVlFmcm1PaU1oWGJ3MTB0?=
 =?utf-8?B?RUF0Qlg5NHJmTUlTS0FTOE44NnFYRjhhOFdPZkV3TnM1V0l0SHBpU3VIMlJl?=
 =?utf-8?B?bU9YTG1NYXV6QjBnWXpBYSsvQk5nbWJ4NEswL2xkanhsR2xlOEVmNDk0N0dl?=
 =?utf-8?B?eDh5WWYyZ1c2U0s0cTExU3J6RnozVkk1TnFYZXg3TTRVQ3I0d0kwdUVZWFdS?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03534A67D9872A42A40B78C4A2F9B784@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R3IwQ3lOVWRjdGQ5N1ZmS0JFbll0OG5rUUlyNHV0L01mcWR3anh6bzUxdElo?=
 =?utf-8?B?bmxkR3hRMkx1ZThTZVRzcVlKbUVLaHk4ZjhUOU1xTERkSXZTdVZ1WmV0c3A4?=
 =?utf-8?B?RzZxaVRHNlBMZmo3TDBQMDVxMThDZTQ3WWZyOThSclF1QTQ3MXprS2tFUGk5?=
 =?utf-8?B?WnR2dlNjUDVhRUlYNDNKenlSenMvRnEvWGFoQ2pXWVpEN3hqVEhnWnlTWWpk?=
 =?utf-8?B?Wkc1dzUwaDROYTgrTGQyQkR3cHdraVFmL0xvZ0ZDc29lN3MwaytxQXRHOFRV?=
 =?utf-8?B?d0J4WXdIMHlCTEZsbFpwZWxQZkV5Z1BKRGFNUEw0WWhuYzI4L1FpTnRjUEt5?=
 =?utf-8?B?eEYvdU9ReHpWWTMvRU1QR0NyYVEvU2xBZTNIS08wb05KNE1WeE41VHZmczJ6?=
 =?utf-8?B?ckxEVFp4YVpjdERGb3NhMndLVVlzUkhET25WUDBmKzJXblA5NVVISGUycHc5?=
 =?utf-8?B?anhIeHlqeEVZcnZpL0JpajIzL290ZUorcmdoWjdEKzZveVgzWDBxaG9TYnl0?=
 =?utf-8?B?L1Z2VzZmWUgrKy9ldzNuZnhGclUxMkpaMVY4NE95MDNSQ3FMcmcrRkx6bVpw?=
 =?utf-8?B?UHV3Q05mLzV0cGFob1NsbEQwd0RtQ0Y5Vld5SFpuY2hqUDZQVG5zRU9PcTlU?=
 =?utf-8?B?R3B4QzY4b1FIaFVCWDI0KysvQTlXOVZZc2kxS2pFb05zcDFFdlk5MUFwV0Jw?=
 =?utf-8?B?Z2xUTFFISjNGR1VTUDRiS0N4M2tiL0V1cEZvQllwU3JMazBYYVBNV2IyKyti?=
 =?utf-8?B?MWdpd1NWc0h2TmF1UXo0VG9SYlUxcmlMK1RBOXk0LzMwazdzSzdpZFZXTmVa?=
 =?utf-8?B?UXJWM05ScVRzbTR5bkpxT1VDUUxBdEF1U29qSFJsQ1FROWdQQ2k2MDh6Mk5V?=
 =?utf-8?B?TEJGTC9Ma3FQNkhvODlhM1VpM1VrRE16eStCU1ZLSXlrM1JSbjU2ZTNSVVhm?=
 =?utf-8?B?cVE2azNvWWErRzA5VTNwR2t4Qkx3RHhDR2M3MUE1UUFyQW12NG1PemxrMllX?=
 =?utf-8?B?WjQ1NjdDWU1NeEpqUkw0Mm96Sy81WEttQVhWTjdGN3plTVlrTFF3bTdIMEth?=
 =?utf-8?B?TExBRnhaR3RtQ1VSc1N4b216TFJZZG5BaEJqVlFvRlZ1bWVJNnVBblBRTkV6?=
 =?utf-8?B?T2tOS3lHVTUrbUgrZXMrWm5uQ01KNlN5Q3FCL0dtTDY3QzVSNndSNjQ1aTd5?=
 =?utf-8?B?NG15a0dBUWhUUldLYlUza3pqQ1U2Y1pPU1o3c2tZVmluSktkRE5Ib2hka2Ux?=
 =?utf-8?B?OGhReS8xTHFEYVAvYzI2WEpIMDlBSnc3a2dpbFZicHhMY3lNQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703c0cc5-00de-490e-b2bc-08daf95b6080
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 13:53:28.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzPmlKrpcQiWd6UnUe3mbP0Qr1Ldayl0vUddrGr1Rerqkd/TofoedYE7tlq2fWjhQ/gJe1GHaHVcvyfYokYcI2/vc9TknCnrlDoBOgYXB5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDEvMjAyMyAxMjoyMiBwbSwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOg0KPiBTaWduZWQt
b2ZmLWJ5OiBEYXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9uLmNvLnVrPg0KPiAtLS0NCj4gV2hh
dCBkb2VzIHhlbl9ldnRjaG5fZG9fdXBjYWxsKCkgZXhpc3QgZm9yPyBDYW4gd2UgZGVsZXRlIGl0
PyBJIGRvbid0DQo+IHNlZSBpdCBiZWluZyBjYWxsZWQgYW55d2hlcmUuDQoNClNlZW1zIHRoZSBj
YWxsZXIgd2FzIGRyb3BwZWQgYnkNCmNiMDllYTI5MjRjYmYxYTQyZGE1OWJkMzBhNTljYzE4MzYy
NDBiY2IsIGJ1dCB0aGUgQ09ORklHX1BWSFZNIGxvb2tzDQpib2d1cyBiZWNhdXNlIHRoZSBwcmVj
b25kaXRpb24gdG8gc2V0dGluZyBpdCB1cCB3YXMgYmVpbmcgaW4gYSBYZW4gSFZNDQpndWVzdCwg
YW5kIHRoZSBndWVzdCBpcyB0YWtpbmcgZXZ0Y2hucyBieSB2ZWN0b3IgZWl0aGVyIHdheS4NCg0K
UFYgZ3Vlc3RzIHVzZSB0aGUgZW50cnlwb2ludCBjYWxsZWQgZXhjX3hlbl9oeXBlcnZpc29yX2Nh
bGxiYWNrIHdoaWNoDQpyZWFsbHkgb3VnaHQgdG8gZ2FpbiBhIFBWIGluIGl0cyBuYW1lIHNvbWV3
aGVyZS7CoCBBbHNvIHRoZSBjb21tZW50cyBsb29rDQpkaXN0aW5jdGx5IHN1c3BlY3QuDQoNClNv
bWUgdGlkeWluZyBpbiB0aGlzIGFyZWEgd291bGQgYmUgdmFsdWFibGUuDQoNCn5BbmRyZXcNCg==
