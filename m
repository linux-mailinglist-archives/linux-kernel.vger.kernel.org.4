Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE0739DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjFVKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFVKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:02:06 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF72DE4B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1687428122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IXE/YD8684+0fw2ydjJowhNGE1JxvY9C6qEH/ogslGw=;
  b=CxbX8FoURDh5p5Xeao9ylffNqKv2rk9RkcC1uLpz5LLnZPBlPzMOyaif
   TkJTf6iR3VEhN4jXqxYWd+KiDXFBkoouuohsB6eSc0PT6KF0+OWVjKtzg
   Vb989aXHQ20YIvCGtI2Q23csMqK+ZWjcCi0Rn3pxEBImitznLxgS5PFbw
   4=;
X-IronPort-RemoteIP: 104.47.55.171
X-IronPort-MID: 113749965
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:gGt8Pq6I3Tke4LAlfGSpbwxRtDzHchMFZxGqfqrLsTDasY5as4F+v
 mMeXWqCM6mKa2L0etgjYdzgpkkG6JGGyNA3SlA5q31jHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35JwehBtC5gZlPa4R5geE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5my
 tkYNyESQUm/1qGU+LKDF/RmqcsSBZy+VG8fkikIITDxK98DGMqGaYOaoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OkUooj+GF3Nn9I7RmQe1tk1zej
 GPC5GnRCRAGLt2PjzGC9xpAg8eWxHikBNNDSuDQGvhCgF2BzzUrVjYqTgGrv+OLhU67QIttJ
 BlBksYphe1onKCxdfHlUgG1umysvxgSQdNcHuQ2rgaXxcL85xuFAUAHQyRHZdhgs9U5LRQ22
 VuZt9foAyFzqrqTSGLb+rr8hTazPycSBXUPaS8NUU0O5NyLiIsrphvLT9tlQOi5g7XdFTjuz
 naKpS4lirM7ic8NyrX9/FbbjjbqrZ/MJiYltlv/XW+/6A59Iom/aOSA6UDSxeRRMIGDCFKGu
 RAsmceE6/sVJYqQjyHLS+IIdJmy/OqMOjDYhV9pHrEi+i6r9nrleppfiBl5IEpqKc8CdSXef
 F7IuQhR6ZlQO1OndaZyJYm2DqwCyanmCMSgVf3OaNdKSoZ+eRXB/yx0Y0OUmWf3nyAEgaw5f
 JuWb8uoJXIbErh8iiq7Qf8H1r0mzTx4wnncLa0X1Dyi2LuaIXSTGbEMNQLUavhjtfzd5gLI7
 9xYKs2GjQ1FV/HzaTXW9ohVKk0WKX88Btb9rMk/mvO/HzeK0VoJU5f5qY7NsaQ+90iJvo8kJ
 k2AZ3I=
IronPort-HdrOrdr: A9a23:BKHo66oMXVk1sIRrIoLTymAaV5rbeYIsimQD101hICG9Evb0qy
 nOpoV+6faQslwssR4b9uxoVJPvfZq+z+8R3WByB8bAYOCOggLBQL2Ki7GC/9SJIUbDH4VmpM
 VdmsZFaOEYdmIK6voT4GODYqodKNvsytHWuQ8JpU0dMz2DaMtbnnZE4h7wKDwReOHfb6BJbq
 Z14KB81kOdUEVSVOuXLF8fUdPOotXa/aiWHCLvV3YcmXGzZSrD0s+ALySl
X-Talos-CUID: 9a23:8MimV26hm7vwU3z29tssy2sUBdE6XSThnTTyG0+AVHtjZ7KkYArF
X-Talos-MUID: 9a23:QGed7gWC4t7Sixvq/D/sljg7DJlD37/0GF4Xo5oGvtLdByMlbg==
X-IronPort-AV: E=Sophos;i="6.00,263,1681185600"; 
   d="scan'208";a="113749965"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2023 06:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPT7brvBUkvIjaaEDN8ghOW3dCwEeEBkT5F8xeYzbXCCyUfNMBL2pA2+ok+bRmm1rFkdn1MZd1eS3MnYFqDrO3V8j/Pow0WxTY6jxJI9NS5k0lFBQBhzW+zR85j3F0fvEalEBpQb1LIqNaChOUEQCs7WXgRoZpyaSIFnMREAszUMBihAUWUli0/9OYTPGXKwz0BYz1QQKU5UsxZhBmjjgMtsvJGhz/srJiwnf9AwT2ci/2GXtWSlQA1Xc4STOX3E6HinyeAkoLpSzJNbEpfdJAgzX+u34xfWQ22caGMe16IOIxz6hdbjPJIiMXlW+ufegFtTk6Tilfd3eTbluzwIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXE/YD8684+0fw2ydjJowhNGE1JxvY9C6qEH/ogslGw=;
 b=AZm/3OwRw/jK7IGJqq+oN1d3OyBtWCs/CZD/jLKnAfAaRYJHzNnQwQUYjJdhAetqgQx7t7dcHZHX0BSlW7SSCS8RpBLKy3PTS6P1vWlygTqJ1W3SsmQCkYRWUIUscl0kK8tnYLJbsjai1AOyZ6fPdRe8SseKpLYVOuDXij1WggU/RhtQXrEbHlxpo5DaRF/f9ArLTF9yNnCEoTTpG+VBOjnt35uF8hDI606Rz9NAEwIr6UgI56A0z5a+MeBuE0COXeGSAv9Ee6cUC9kdX0hLNeUQoJM/EBQj9TkWIAcpByGhV0BKrWZ6yNZWWynJttEk/Szgt7YnzbfZyE9Qz71A5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXE/YD8684+0fw2ydjJowhNGE1JxvY9C6qEH/ogslGw=;
 b=dH/oeqwZ003iN8TGiQq6ZOYRFqzT5HKcBAwazWlqNjAOMND6b1e5XW7TQWpjH6CR9g8UwIiq1BLF5ZIHxIQKq9Jd6hKl9AW0BNzBMkreL0VKxxhKS3p40TbJdQDDxS7gwBmVp/PSniIOs8+BleVFJDaYOc3MihM/nRoXgTaWn+0=
Received: from SA2PR03MB5881.namprd03.prod.outlook.com (2603:10b6:806:11d::18)
 by PH0PR03MB7160.namprd03.prod.outlook.com (2603:10b6:510:294::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 22 Jun
 2023 10:01:55 +0000
Received: from SA2PR03MB5881.namprd03.prod.outlook.com
 ([fe80::6646:2936:9a61:97b4]) by SA2PR03MB5881.namprd03.prod.outlook.com
 ([fe80::6646:2936:9a61:97b4%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 10:01:55 +0000
From:   Per Bilse <Per.Bilse@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Thread-Topic: [PATCH] Updates to Xen hypercall preemption
Thread-Index: AQHZpFMl91hHG7ZDuUq21h7QjP0mVK+VdZEAgAAsiICAAAxVgIAA6kGA
Date:   Thu, 22 Jun 2023 10:01:55 +0000
Message-ID: <f1b5badb-8d40-ec03-400e-4789ef4cba57@citrix.com>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230621200409.GC4253@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR03MB5881:EE_|PH0PR03MB7160:EE_
x-ms-office365-filtering-correlation-id: f089e7d5-7ee7-4d54-76d9-08db7307b5a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1gu/eD3mXq/AXt3M7Tqymjh6rdbrjjuqAkFtZCRVZ3nxcji9E6hRUilD4FJAQmotRCcwa8MBMPXs66/+e+fNd+n07Td6bk6h+wZL0lKBQ/c4vAEqgBp5Brs1Cq1LrK0kAveVoZL1xbuUvbQISdas3/N17u9vDKz+Xy0u7wZgSebk/vE5ktyG+/iZC7ZLgSO379k5E1kZaddGLIoazshc9GE4DY3EkTkysMAXk2AP+Ald6it7UdZrSRhREUsb6Ep7jZZKIdu3Lp7u/8ARt1E8wvVV1ptj/huLtzLU8a6VQvKmXartrNL2pL772+qXNoIcxYMG3kpQ/WnOb8e24z9CGstqQd1X2K7RikrvAL4QtMNbUxaWTrJHQZLNabPRsTl1QmVB1uB0Ub3URv/ge3tQ3xGRaRtnTFZn4/olVECx/FAKTaf5GRhA63nh8cvmdDcfBHfTyEsSMx2U52H048kI6hNfBQu4d4kEMNTfNVXnwBjiSO8ceX5KcVzcflOIVu1KnObVlbuXRZ+qJd5KBFeHrO/2dxv/10sE5O3UFOh8qaERZL8AYnXQUgXylPl8SfhrDIb0lRwp9uee7cULo9Ep2TNF5Bz1jIHIDuqYS8GcFkmSCwf6F11g3KkqUx5McLo2dZQ0YGRvXDTniuSNci3pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR03MB5881.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(41300700001)(15650500001)(5660300002)(71200400001)(2906002)(31686004)(316002)(8936002)(7416002)(8676002)(91956017)(66476007)(76116006)(4326008)(66946007)(6916009)(54906003)(478600001)(36756003)(86362001)(31696002)(38100700002)(53546011)(64756008)(66446008)(122000001)(2616005)(55236004)(66556008)(82960400001)(83380400001)(38070700005)(26005)(6486002)(186003)(6512007)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlBOYzlqV0xaQVNVZGZEci9Bb00vNzdCMG1ZbU9YSWZBZ1NyN2pwTXdmYzFm?=
 =?utf-8?B?aU5uWklwNGZuZzFNSVJpbWJTTjZVdlg2OXdGMytQbjl4eTJXUDZHMTJMeStE?=
 =?utf-8?B?eTYzNVEwdHZ1bVYrdnk1SHZqS1g5dGxLV1dIT0ZQNTdXVzdxVHI4WWd0UDJT?=
 =?utf-8?B?MHdwQ3p3bU9zUkFTcXRXQVBpV2dBZEozeGFhYWRoL3RhVXZxbmtQSjJPa2VL?=
 =?utf-8?B?L0xQL280emxhWXptMlA3dGtOOC9SR3BUWlBjQlJGbmNkc3V4SENFaG5UZHRP?=
 =?utf-8?B?Wi9Ib3FZZGkzMWRoRU1FZDhablpGRkVrbEtxRnFBd0U2T1JKeTlsTlZuMk5R?=
 =?utf-8?B?WjBwU2lsOGJnTUh3NTJxNCtTQUVhSno0SlVZQ1o3Q29XK25CeTVBMzRxRkFn?=
 =?utf-8?B?SHozR0xFejJHVlZ1ZDRYQ21wUzJpRnNQaDVYWUJpZFpYNW51S3N4Kzlab0Vo?=
 =?utf-8?B?YTVyNGtLdkNVRXhhc3JEWkFiaFJ6MW1nUVFwenp3WGZnemlEd1hBbElCeWpL?=
 =?utf-8?B?U1gvZDNjdk56L3haUDFnUEFTMzRadXBJZTNJMldIUDZGSkczSklNL2pxRTRU?=
 =?utf-8?B?aGRkTitYNWk4aHU2MzZDNkFpT0lFdHFsdllmT211UVdXSWNaRGs0c09zWTFD?=
 =?utf-8?B?TCtNSGMyajRTRU1tbGdWcVhsMjdKbXlGY3lBR1JtTU5BcjcybHpscmUzVnl5?=
 =?utf-8?B?WkFmczRzZlJoRWN5N3VVY05rN0hrbURMcXozZHNSY1crMklaeEtiZXZxb2dW?=
 =?utf-8?B?WVcraSs0Rjh3bjJGa2xFTVQ3SUZtaUxRN1h6aThwTmhXZHVPWnBXbWZBaWpX?=
 =?utf-8?B?Y05zUzlhUWdPaHhpU0xNU3JIdGtjaFVoRFBGYS9jNFA1dkNZeGlQTVU4ZjR6?=
 =?utf-8?B?QlJzL3REU3hwdHBNTWpOajRwRGVxaWR0NVg5V0hCZ29SR2RnL3hsd2tXNktj?=
 =?utf-8?B?V202Tndac05xVzVadCtZZGpoMUhIaG9PSGloZGljZXlQeGo5QmJHOG0wTWV5?=
 =?utf-8?B?VHhUa2VwTW5lOVN0RnBNZk5pSTFQclo2WFJzN3pzZXVaeXJsbSt5Vm5iYTV1?=
 =?utf-8?B?MWUzcDFsSzlBSnFDVVlKaVBMQWhoN1Y5SFB6Z0MyemVUZSt5TUhSbUVCalFF?=
 =?utf-8?B?YjZmMEVBNVRUWkdLMTVUenQ2MVpxN21VUkVtNGtEL09ENjEwem1sV2lEL3NY?=
 =?utf-8?B?WXVoMEFXWlhxZEpmSU1KQVlzNytPUERzblIxQ0JOV09NWWxjdlB1YjU3QWVB?=
 =?utf-8?B?MGYvM3UrdjNTM1VadFViQ09uVGNLZjVwdm1kYnZTUzlUTzg5c3l6R1ZsNU15?=
 =?utf-8?B?dDU4MWVNZ0thMFhsbUdEaWhjcWJyMGFwMS9GV24wTTZUWFVZTnVtelN5QTht?=
 =?utf-8?B?cHlLOTJrVUFROHVlaWhXQkxHL1FzUlkwMTljbm1DVkwvaDIvQjRuRUVzZ3Rn?=
 =?utf-8?B?MlRuYUxVaVdYMi9oeW1HdzhZdlRiWVBJUVFkMit0SUZDdy9sN0VJQ05tTUdl?=
 =?utf-8?B?M1llOUsxR3RIbnRSbkZ1ZFUyTjJuV3lkYUJ3WGFTbVFXSjVvaXk2cWxCN1dU?=
 =?utf-8?B?cWJUTTZHVWtEVXVpOGp5ZTQ0cHhXQWROZktUL1V6RmhBb1FsVk1ETytDMnVv?=
 =?utf-8?B?dkVORXI2blU2V2Z0OFJid3pCb1J1Zm5HZ0dZdGJiY1o1UXc1Z2kxWGMrVGhD?=
 =?utf-8?B?WkRLMmxzRCtWM08zRHk5MkVGNjlOTHA3eTVnNWxqcWZnQTVpcG13enRyeVBr?=
 =?utf-8?B?d2F0Wk9XdGtGdmVpMVh1TjFpd1FVWUFqc0IxcEpvWFMzQXZFZnh2UWdVdlVJ?=
 =?utf-8?B?Ni93Q3cyaXRKSm14YjkrWjVONUxyRjc2bzdGRThLTnNkUWNCUXlxVVlYVm5B?=
 =?utf-8?B?bmRvalptbU9yZUVwR2l0NXd3K1JjcEZLUFNWc0kyWVpyQ0Q4bSt3eFhuakk3?=
 =?utf-8?B?SE53Q3JHRGlVMzVKWHdZNnIrOG5RcVIvdE9saEJibjRxQVpQK1l0U09RSFIr?=
 =?utf-8?B?WkF1VzVxR2hVYVV2Y0gzMkNlL2lLdHdWby9zZ1lBVGJjRDNHbURGcXBSS3Yw?=
 =?utf-8?B?RE5JSVZiTUV1bVVJVGtIQlQ5THRzdW5jSjJvUzRJUHo5aXp4SDNtd3NRS1Mx?=
 =?utf-8?Q?64Vs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA41FD48B1862D468F6090D5078EF8E9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dFpZNlE4cmVLdlFzRytqQnMwMWpSYzdwR1F0elZrTnk1NHBiUlNYZzFLczlV?=
 =?utf-8?B?SjV5VXZuTlBQdjZFRGFSUlo5dGNKWVowcUdHdGNuVnIwNm5FeXdzdExpZEhC?=
 =?utf-8?B?RldLREdnK0Q5bTBGTUVDWEpmaFF1VGw2T3AzVjZSNFR3TExkUlpDUkI0Q05P?=
 =?utf-8?B?ZWdjZ0haa0tBbWZuL2IvblhTQWpIYjZsS2tMREMwc09XNFpRc0p4bDVwOXhz?=
 =?utf-8?B?b3hoUS9OeENBR3dPbGx5SW9nRFFQQW1ZdnlFMFJQZzNOb3BCZmZHeGNEVzFC?=
 =?utf-8?B?RkdWdUI0Mk5sS1EvbHJiR0ZWcWZIK0RhdkIyYmtEOXlVRkJsTUt6TGxoVFFs?=
 =?utf-8?B?bUdWUlJmbDlEZDNkUEM2RDB4M1dJa2JCVUpLL0FOcWtUOTdJUkxOa2N6cTJt?=
 =?utf-8?B?bnhLQ3JKUVpWbDA2Q0Vzdk0wSkRqNEFqcXdYZ1REem03ZGZndVpUbjdraWZG?=
 =?utf-8?B?WlJSR3puYXE1SFYrL2lqNGR1M3NieElUMEhQTFU1UzA2QVRvWTViUW9CQkd5?=
 =?utf-8?B?QVJUcUNUK2ZzQkZXU01kUG11S05IckpFeDhoUjRSVWlXVG1yN0RCSEt2cU85?=
 =?utf-8?B?T1lpWkpyeW5TK3lRZ3R0MDlnUmluZU9rUUNwQWNCcWQ2L1VFaExOamo3R0xl?=
 =?utf-8?B?TFV2aGtTdysyRUh0elFsVFIwcVo1eTd5ellaVUpMYkdodzlsdVlVaEVHS2FE?=
 =?utf-8?B?Ni81dUp2TlJaTG1QREhkbm5CUm1Sb3dROEJmUlcva1NKSzg5U3Z5c1pJK3RX?=
 =?utf-8?B?VWMralRDZGg0bzR2RWZTSXF3SmdZRG54bGNrOEtzRjVUNEo3T2ZvSmhaTTUr?=
 =?utf-8?B?eXlyYUVweHQ2REhiWXZMT1N4ZFUyVUNOUVZsdFptVmozRzlwWnNmVUlyQ0tJ?=
 =?utf-8?B?c1hIczVNVjJCeHd2aWFLRHoyZndFQ1VNYW5TeHMzeFJFZW9TVDFSeDlqcGxv?=
 =?utf-8?B?ckprQlhyM1F5dkJXT29BTTF1bVlvLzF5ZStZa0VoYmlnUlVTbUtWbVRDRFA2?=
 =?utf-8?B?SWpWNXNUNWpYSWthenFUT1IzSzRVWlQ5ejBhTXl2N2d6MEdTaHFxb0FTRlVI?=
 =?utf-8?B?VFA3NjZEODFndUJBUzJ6eGUvVGF3MHlCc1hiTXlST29qVnRNdk9VN1cwVmFP?=
 =?utf-8?B?dXhwWk12TWdiR1JwOEhGc3FjRnpmd3JnWnRPclhUelZ6Z0gvT1VpWlZDVXNj?=
 =?utf-8?B?eGhRSFErRnd1Y3VyMmRML2t6bmF6alQ3akVOVmZReDdndVZhcjRrVURGdzVI?=
 =?utf-8?B?MmJlL0QveUJZbmNPWEJUV3R4aU41VTMxeFFhd3RJczZXTzdzTW5VcGZvNk9w?=
 =?utf-8?B?S1hVemJ2cHRsdXI0WFU2Zk1zOFd2VHlEZ3pJMXMwNTByTHlQbjFzR1c2K0NY?=
 =?utf-8?B?T2syYjRpU3ZHMGlnV0VLbnV6aFRrRm9VMGNIMzVMWHRIUDFmOWpxMjdVYkZt?=
 =?utf-8?B?RFhnSWNWKzc3ZjhkeFBtcUROL2JmbnVmekhSbkcyaEtjaDRFVzRDMERhcEQv?=
 =?utf-8?Q?26ZAYE=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR03MB5881.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f089e7d5-7ee7-4d54-76d9-08db7307b5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 10:01:55.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHQfntZjve1+a979ZqK0A+Ak3hC1bj59bzMaoafVZBPlp/Hm1vWkcTIuW6o4kOl9f8XOnchlvxhknlbwCB7DTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7160
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMS8yMDIzIDk6MDQgUE0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQsIEp1
biAyMSwgMjAyMyBhdCAwNzoxOToyMVBNICswMDAwLCBQZXIgQmlsc2Ugd3JvdGU6DQo+PiBPbiA2
LzIxLzIwMjMgNTo0MCBQTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4gSSBkb24ndCB1bmRl
cnN0YW5kIGl0IC0tIGZ1bmRhbWVudGFsbHksIGhvdyBjYW4gbGludXggc2NoZWR1bGUgd2hlbiB0
aGUNCj4+PiBndWVzdCBpc24ndCBldmVuIHJ1bm5pbmc/IEh5cGVyY2FsbCB0cmFuc2ZlcnMgY29u
dHJvbCB0byB0aGUNCj4+PiBob3N0L2h5cGVydmlzb3IgYW5kIGxlYXZlcyB0aGUgZ3Vlc3Qgc3Vz
cGVuZGVkLg0KPj4NCj4+IEhpIFBldGVyLCBhcyBub3RlZCBpbiBlYXJsaWVyIG5vdGUgdG8gQW5k
eSwgdGhpcyBpcyBlc3NlbnRpYWxseSBleGlzdGluZw0KPj4gY29kZSB0aGF0IG90aGVyIGNvbW1p
dHMgaGF2ZSByZW5kZXJlZCBpbmVmZmVjdGl2ZSBvdmVyIHRpbWUuICBIZW5jZSwNCj4+IHRoZSBm
aW5lciBkZXRhaWxzIG9mIGhvdyBvciB3aHkgaXQgd29ya3MgaGF2ZW4ndCBjaGFuZ2VkIHNpbmNl
IGl0IHdhcw0KPj4gZmlyc3QgaW50cm9kdWNlZC4NCj4gDQo+IFRoYXQgZG9lc24ndCBtZWFuIHlv
dSBkb24ndCBoYXZlIHRvIGV4cGxhaW4gaG93IHN0dWZmIHdvcmtzDQpIaSBQZXRlciwgZmlyc3Qg
b2YgYWxsIEkgd2FudCB0byBzYXkgdGhhdCB0aGUgdmlnaWxhbmNlIGFuZCBkZWRpY2F0aW9uDQp5
b3UgYW5kIHNvIG1hbnkgb3RoZXIgcGVvcGxlIHNob3cgZm9yIHRoZSBrZXJuZWwgcHJvamVjdCBh
bmQgdGhlDQppbnRlZ3JpdHkgb2YgdGhlIGNvZGUgaXMgaGlnaGx5IGFwcHJlY2lhdGVkLiAgSXQg
aXNuJ3Qgc28gdGhhdCAid2UiDQood2hvbWV2ZXIgdGhhdCBtYXkgYmUpIGFyZSBpZ25vcmFudCBv
ZiB0aGF0LCBhbmQgSSBoYXZlIHBlcnNvbmFsbHkNCmVuam95ZWQgdGhlIGZyZWVkb21zIG9mIEJT
RCwgYW5kIGxhdGVyIExpbnV4LCBzeXN0ZW1zIGZvciBsb25nZXIgdGhhbg0KSSBjYXJlIHRvIHJl
bWVtYmVyLiAgVGhlcmUgaXMsIGhvd2V2ZXIsIGEgc2NvcGUgdG8gZXZlcnkgcGF0Y2guDQoNCklu
IHRoaXMgY2FzZSB3ZSBjaGFuZ2UgQ09ORklHX1BSRUVNUFRJT04gdG8gQ09ORklHX1BSRUVNUFQg
aW4gdHdvDQpwbGFjZXM7IHRoZSBvdGhlciAocXVpdGUgbWlub3IpIGNoYW5nZXMgZm9sbG93IG9u
IGZyb20gdGhhdCwgcGFydGx5DQp0byBhdm9pZCBhIHJlcGVhdCBpbiB0aGUgZnV0dXJlLiAgVGhl
IGNvZGUgdGhhdCBpcyBlbi0gb3IgZGlzYWJsZWQNCmJ5IHRoaXMgY2hhbmdlIGhhcyBhbHJlYWR5
IGJlZW4gdGhyb3VnaCBhbGwgdGhlIGRzY3Vzc2lvbiwgcmV2aWV3cywNCmNvbnNpZGVyYXRpb25z
LCBhbmQgZ25hc2hpbmcgb2YgdGVldGggdGhhdCB0aW1lLWhvbm91cmVkIHRyYWRpdGlvbnMNCnJl
cXVpcmUuICBNYXliZSB0aGluZ3Mgd2VyZSBkaWZmZXJlbnQgYXQgdGhlIHRpbWUgaXQgd2FzIGNv
bW1pdHRlZCwNCmJ1dCB0aGF0J3Mgbm90aGluZyBuZXcgLS0gYSBmZXcgeWVhcnMgYWdvIEkgd2Fz
IGZpeGluZyBJUHY2IGNvZGUNCmZyb20gdGhlIGVuZCBvZiB0aGUgbGFzdCBjZW50dXJ5LCBhbmQg
aXQncyBlbnRpcmVseSB1bnN1c3RhaW5hYmxlDQp0byByZXBlYXQgYW5kIHJlaGFzaCBsaWJyYXJp
ZXMgb2Ygb2xkIGRpc2N1c3Npb25zIGFuZCBjb2RlIHNpbXBseQ0KYmVjYXVzZSBhbiBpZmRlZiBp
cyBjaGFuZ2VkLg0KDQpJbiBhbGwgaXRzIGJydXRhbGl0eSwgdGhlIGN1cnJlbnQgc3RhdGUgb2Yg
YWZmYWlycyBpcyB0aGF0IHRoZSBrZXJuZWwNCmhhcyBidWdzIHRoYXQgd2lsbCBjYXVzZSBpdCB0
byBjcmFzaCBvciBvdGhlcndpc2UgbWFsZnVuY3Rpb24gaW4NCmNlcnRhaW4gY2lyY3Vtc3RhbmNl
cy4gIFRoZXJlIGlzIGNvZGUgcHJlc2VudCBpbiB0aGUga2VybmVsIHRoYXQgd2lsbA0KcHJldmVu
dCB0aGF0LCBidXQgdGhpcyBjb2RlIGhhcyBiZWNvbWUgaW5lZmZlY3RpdmUgZHVlIHRvIG92ZXJz
aWdodHMNCmluIGNvbW1pdHMgbWFkZSBzaW5jZSB0aGUgY29kZSB3YXMgaW50cm9kdWNlZC4gIFdl
IHRob3VnaHQgaXQgd2FzDQppbiBldmVyeWJvZHkncyBiZXN0IGludGVyZXN0cyB0byBlbnN1cmUg
dGhpcyBjb2RlIHdhcyByZS1lbmFibGVkLA0KdGhhdCdzIGFsbC4gIEkgZnVsbHkgc3VwcG9ydCB5
b3UgYW5kIGV2ZXJ5Ym9keSBlbHNlIGluIHlvdXIgZGVzaXJlIHRvDQptYWludGFpbiB0aGUgaGln
aGVzdCBwb3NzaWJsZSBzdGFuZGFyZHMsIGFuZCBhcyBJIHNhaWQgdG8gQW5keSB3cnQNCmhpcyBz
dWdnZXN0aW9uLCBJJ2xsIHNlZSB3aGF0IEkgY2FuIGRvLiAgSW4gdGhlIG1lYW50aW1lLCBJIGhp
Z2hseQ0KcmVjb21tZW5kIG5vdCBzaG9vdGluZyB0aGUgbWVzc2VuZ2VyLg0KDQpCZXN0LA0KDQog
ICAtLSBQZXINCg0K
