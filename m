Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F86C33E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCUOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCUOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:19:18 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A184212BE7;
        Tue, 21 Mar 2023 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1679408356;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5LmAvDBTWRDOqdDmpDUoEIMQDZqxfw78ew8VuXI53No=;
  b=esZOIiP3dZFh5HmxJqqUvD7udDkqVfXWvygP/Ve4RB6vTv6VE9bEFsY6
   lEah4zbc4y9lzJtog08JswmRGRHUt5wZnxk0HTpDQVM+CqwLez+8u5vKo
   YjJ0bkC+M6mpAd+eM79w3B50b7ZNK0rus8GL4ZGnGIV1ZHXZz9Xc7lD57
   4=;
X-IronPort-RemoteIP: 104.47.55.177
X-IronPort-MID: 101716948
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:BRkLEK7wM2S56s8WspsuzwxRtGTHchMFZxGqfqrLsTDasY5as4F+v
 jRKCGCPPanfZGKnc4x2a9i2o0oD7ZOEmN9qG1M+rXg1Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+7JwehBtC5gZlPasR5QeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5mz
 aEEEiEdZBK6ldn14JKwcPBcl8MOBZy+VG8fkikIITDxK98DGMqGaYOaoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OkUooj+eF3Nn9I7RmQe1PmUmVv
 CTe9nnRCRAGLt2PjzGC9xpAg8eWxXqkAdxDSO3QGvhChnOM4UgpOAIqT2C4iKG/tXTldfJeN
 BlBksYphe1onKCxdfH5XhulsDuHswQaVt54DeI38keOx7DS7gLfAXILJhZRZdpjuMIoSDgC0
 l6Sg8ivFTFpqKeSS3+W6vGTtzzaETIcI2YPYQcHQBED7t2lp5s85jrLQ9BpOK24lNv4HXf32
 T/ihCoxnbIIluYQyr62u1vAhlqEvYPVRwQ44gHWWGON7Q5jYoOhIYuy5jDz6vJNL52QSFWbi
 2QVgMiV7O0IDpalmTSERaMGG7TBz+iINj7VnVN0H985/jCp+maqcYF44TdiKUMvOcEBERfga
 0/SsAVezJ9LenCtaMdfZ4O3FtRvxKP4FPz7Wf3OKNlDeJ58cEmA5i4GWKKL92XkkUxpm6dvP
 56eKJyoFSxDVvshyyeqTeAA17Nt3jo52W7YWZH8yVKgzKaaY3mWD7wCNTNic9wE0U9Nmy2Nm
 /43CidA40w3vDHWCsUPzbMuEA==
IronPort-HdrOrdr: A9a23:LCc9BaO4IiRHNcBcThajsMiBIKoaSvp037Dk7TEXdfUnSL38qy
 nIpoVg6faUskdrZJhOo7G90cW7MArhHNtOkPEs1PSZLXfbUQiTTL2Kj7GN/9S6IVyAygc178
 4JGMISZLLN5BpB/KDHCWKDYrQdKbe8gcSVbKvlvhRQZDAvT6lh6gd/BEK/EldqLTM2dKbRDK
 DsmvavuQDQBEgqUg==
X-IronPort-AV: E=Sophos;i="5.98,279,1673931600"; 
   d="scan'208";a="101716948"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2023 10:19:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSU8oulaMZ1ptrCSz+h5oWjKWq5IJiyTZtONuEAF1JXv/+RTJhfPEtUNwBucfEvyhYeCc7632bLZ+2hbPtcmxAmv+B4b2crbAFti9sZpqgK50DfmyfdqnSNICyLTlNoJYbncJK567N24/doYgbdGOAosOqwLtknFbfhlen1aqZyjUbgPVO6qdUpE74evq6JQDKpAh7pESJK8dTzr+zN9AlbwlAcjlqry2sttigDIPHJAYsI24iSFWyeuQsYOQoVf+FQG+qQEhrh2Zsy98x++WnqWRrrdHfrd/VwxWEAjqsA0+gzLmLkMcTOHKQk1JDM789sprH7QUzT7iGgWWydW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVwGHov7/G5EPBSgvaEw0y/gpmVnGy2Bpc97qeTApaI=;
 b=MZ4kNbf85dPdDLwGp6Qqdc6Ij4i/Jk6gd6DRQIif3ar+fY+QyaNNv6QPPE74hQkF/cGTAg2v85oTwd0vJbtrqcvDADnBVycsYrq8okdTfBRi/GoPf6EMqdsmGjGMeV0PJL+7Ma4RoQpXPQddoWWSE8I1tV4vA03ZXDbT9FW+ZyqNI5zU+Zpd6kAkIT1zMDQgQ394mMDbiCZex4NBvdsuuF6JeHbt63roRmCG9goHUXA4SWAwwKYtNQV0ApW3RhAu5dU2xsM7AA+6P9Cr3SM5jQAwrJgkk6I8xkDN2YuJhDl0TM24qsa12OrEjCEp9qw5gVj6nFkfhiHk/oz2m6gxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVwGHov7/G5EPBSgvaEw0y/gpmVnGy2Bpc97qeTApaI=;
 b=v44X4u7yCOujmg0wLYoSb9FQjIRQEwnNTZOscJhagPDGHrcqK0zH/+Og8TVulAAih63v3qTAjg+e/nYsxc9EpJZe9dHFUsyP7mgoaGrPlS6f5CKwpEwneJdOLlPNK2fzK/e5NSt12WvBE5sOliQjnqdjixjWEvh9KrIuayoj17c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by CO3PR03MB6775.namprd03.prod.outlook.com (2603:10b6:303:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:19:11 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:19:11 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org,
        Roger Pau Monne <roger.pau@citrix.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when running as Xen dom0
Date:   Tue, 21 Mar 2023 15:19:03 +0100
Message-Id: <20230321141904.49177-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0390.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::17) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|CO3PR03MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 184262f4-7a47-4563-eac8-08db2a173d7d
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TL+zIuY5jbXGA0beUnf0t7RbBnEvVmwi8hLHGWey3Coepek6SvNQFYkV9u7H7VOGW0ddsdOrN/r6d/g1oloR5MV0dulYIAAKiOhXrkyw1KnlRR5iKP6MvIopUxZik+ccKn3vaa6eputjGxVEpx/qEaUS3P4E45yWrcpH4cKKqCfEENKiJ/LVDhwFDunUuDzF3JkdKloqWw9lTRlWZ4T/lz9TrIYdXlZw1ExUc3TspQuBqxzdAHgfNv5hNW3wOoJXuTDGJH7kXFgE2aKq6MHvUOkhYxqwSwXOc5El5iO3rH43sXjpTbHln7LtDXcF1jRUkcM/UIYVRn8Wod2UgS/WYP2wpuOzn/vp6mPj5qA+mlNoVg+W8pd+J1gV4NsCds7EbrmbfJ8mJ9ocXN1nMZ6bt9RLtENgBFguDCgwI3lqE7HaG2u62uLxJAZsXNtazmT/lBt6U/FsIquLxDvALCGtwMyvX4FNW3KYAjupor07hbEwfciQ1q3r7A8IuYgyOqe1MDtgAjRJpNpWiRrnpd9dwegu1aDSJoXclOdVH7lHpZF406dkq5ixWaVXzVaLT5tJSfl7C/uNVj2mZRH6F0aU/SuLmzTSb1E5jNyM+bGFF4zqK4jD5WcBZ3xh/EZEZrsN+P17Wh9v66nWqUWjxZin3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199018)(5660300002)(7416002)(6666004)(66476007)(6486002)(41300700001)(66556008)(6916009)(83380400001)(478600001)(316002)(4326008)(54906003)(8936002)(36756003)(86362001)(8676002)(66946007)(2906002)(2616005)(82960400001)(186003)(38100700002)(26005)(1076003)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBuTXp0c3Y3VGJ2c0xmNGRHMk9yN0ZFeTdocnBRd0JuVEhXMFQ1bWNZYS9z?=
 =?utf-8?B?NVBiZkROU2VIaWpreEwzQlN3V2dQL21ZenNpQ2g3Yi9FVFJtSWVwbWNNK1Zp?=
 =?utf-8?B?NmxJOEVEVll1UHp3eDc3TjVyTkxUNERXeWpFY0p6ZlVXbXVZSWNuWWNQQm9a?=
 =?utf-8?B?VFpHQzY1YXVkdkZFRTFmeU13a0w4ODVNR2pnWWtxQmZRMFV0dmdaeXVOQmM2?=
 =?utf-8?B?YmtFb2hmY2dWb3dhMkgyR3cvc2M5dHgySEdZZ01TUjhhOHJVRy9ydHJ0QU9z?=
 =?utf-8?B?a2hoL3lCMHhGMmJTL0Y4YnVQOHRLUXpzeFBVYkJtemZoL2gxT0RtRkJHcGF4?=
 =?utf-8?B?UXJ2Z21nRUNDTDFRWVNIMzUyV29hMENRUlFxdDYwSHN2bHFweVhORTM0Vm82?=
 =?utf-8?B?R3N0U0FHaVdDMG9hWXJmWDFrWjMwWWV6RGpocFlodWh2cW00ZU9sa0ljdlhH?=
 =?utf-8?B?Y2NhZ1Y5czBTTW03TkxkelNqNit3ZkdOK29lNUV2NWdDSDRQN3dQenoySmdZ?=
 =?utf-8?B?YmdaQmVXbTJFL0ZtQlUrOEpmY3R5VUE5bGZYdjFVVndRa2tzY1RaaGV6VWpy?=
 =?utf-8?B?bDhTVU1EKzdsWjdrT3VKd2VKU24vZjAyYVRPWEw4VXkyUEtHekt6OUhkdFNH?=
 =?utf-8?B?VzA2ZDJnVEJINVA0TjkvelNFUjJWRDkxRGdLdStRK0xMWTQrYUlnODdDcjl0?=
 =?utf-8?B?T0gxNUNGUzhXekNiWERORkZwN3V5RmZiM094SFVVQU03SElVZGlCUlBLcndI?=
 =?utf-8?B?Z1NsSkdHMjBFMjJhNjZHZXBPRVZMZ3BwbW0yVWRaSGdpVnM3UDA0SWhuNmkz?=
 =?utf-8?B?Q2ZVOENrMFRLQ0txM0VVVEJMY1JtaEc4L05hTEJSelpPU2tiK1EydTRKdEt3?=
 =?utf-8?B?VnFvZnYwUkE5WURMVm5OR1IvalBiZU4wK3l2c0RkZDhKakMwM1BtWGlHREZB?=
 =?utf-8?B?dWhPYzRWUTEwcUIyTCt3Vmk3T3VhRDhuNkJsN1h6REpJb3FiWkRIaUVVVWVq?=
 =?utf-8?B?YlBMYmRrY2xacjhOYXBiZ0VjeFVCS0RTZWh3MzE4S2hUTFdzMXNic2wvNU5C?=
 =?utf-8?B?QU1PdUtteGNoOEJsSWVLcVBuS0xxY2UybHpzaS8rbkI3SmdKdStHeHVCYWh5?=
 =?utf-8?B?UFErNWQ5RnQ0OCsrYXZ4blBwZnRGRGN2U3pHTWlzaFpnWDN6ekV5M2NLVzZJ?=
 =?utf-8?B?RlJCbGlWQzZYYnJ6R09kOFVpSDhsalJDaXVrL2pZVVNDcXBmZGRieHBEVGU1?=
 =?utf-8?B?YzJESDFLOVF2ZjEzbDc4ZVBHcEp3RVpIVERTYmVPc1FpTnRBWE9lekhOOUJD?=
 =?utf-8?B?dXdORlJrNU5LOVA2c2syUkZnVlc5dWhRWmxlL1JoWDNSM3J5clhhRWYrQ0Rm?=
 =?utf-8?B?Sk1pMkVBS2plbHkwaHhKdmR3c1hTMC8wazdibXFpclZhendBRGFpcVhicjZn?=
 =?utf-8?B?blZxQUZ2TXlDU0ZiRmpWdCtHVThxT1MzcUlIQitpTlRVbWlYK2lpSUNtTkJT?=
 =?utf-8?B?QnIzV09XUWxjOUpqZVBRWGpUT0hOalY5TTcwV2tSdG56NVZLdXZkNFl5YlhI?=
 =?utf-8?B?Z1FMSDYySzd1WklRMGhnUDh3cWI1UC9Wd1dQdFFEL3FEdkNCemJoMXBWazV0?=
 =?utf-8?B?YVEzR2pRNXM0cHlCWm1qSWo1Q3NoT0l6Z0VvRCtERVppclcxOGE2cllwNk5L?=
 =?utf-8?B?SzRCcHNPK2MzVlVxenJpbHhPd0pZejBmaXh0SGRVd2d5ajJPdHMyL0w5K3du?=
 =?utf-8?B?WmlORHprcHVQR3RzWVRXSUNHYU1wRGJObG9KU0hFTldTdUk4RXB6OGZuOXdv?=
 =?utf-8?B?QTQ4anFEbHZlTVo1cW1xSlpId24ySDRhdUZUbTZPUFlPbSs4N1Joc2ZHaG1k?=
 =?utf-8?B?SCtlM1VSTWtDQjdLb1IzclRBNWI0bFNXdk5UZVJXMjNFaXhZOTAyRTJNMVBz?=
 =?utf-8?B?WVMwT3VVY0t6em9TSWpJUTE2YTV3TkJVTDJRTFhNMld4SjJDend4ekM0NjZw?=
 =?utf-8?B?YnphaHlOdk1rUzZ4SWhvUGlOc1RHakk0R3dzUE5ZMGFCdnZOaTlSMVBJOW94?=
 =?utf-8?B?anhEVFVDaW53dlNQYitNUXlpRjVpb0tTOWV3T29UTStPWDJiVjdLQitYWFVN?=
 =?utf-8?B?clRTdm1RakRycnZEcGNhWE5IdU1BMjRzcVJLN1BKU3RHaXhvNVpJUHJwMmpW?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2c2RWR5WW1hUlRMTUl6M1IxbWwrcW1GbitiUVduM1R2bklEd3RsWEN3Tmp4?=
 =?utf-8?B?TlBGZ0hYNjM3YlQ4VFVwaGxKTkVzZXl5eFY2NXRIMmwwNmNKMGdMYzJKbk5T?=
 =?utf-8?B?ZXJJeTNzQTRvYlFiV2RwM0pvU1h1b2pOeTZQSmw5WmxCZTdzV01yRWFTcHg5?=
 =?utf-8?B?eTNUNWtoWlZkZlhvam1waSttYzFKN1JGampGOGFUdEZ1NXJ6cTVYMUNSVVFp?=
 =?utf-8?B?aVZyT3k5dEV0Y1pYb25MaGdjdmxFUWk2bm9KYlI4UmU3c25uQ1NpY0tjdzZS?=
 =?utf-8?B?ZzQwOGdadExLdUZRQjYxbDd1bUx2ZFRmNjBSUE5wbVhCQXB6RXVrdW5JT1VU?=
 =?utf-8?B?d083N0JTWjFDNzBTZlZTWGR5eEhoVWFCU0ZZamh6OTA0OVZPOCtiWEtOSk1h?=
 =?utf-8?B?TXFYdjE3VEk4UlFOTVlZY0paWUtOTW9DcXh4Z3E5bHhJV3pEMm5BRmFaMzVx?=
 =?utf-8?B?dVpSUHZZQ3cyaWRIS0NWeVYvSnl5dStDdkE3WGVpdHJNaE10dm9BcVZYdkR3?=
 =?utf-8?B?bFNRUjRtZFZldUFXK0ZNZGc4Rk9NQ3hSNmgrR3B0aHV6WTNlVXd1WDc0STR6?=
 =?utf-8?B?cnBwbkUxVEFiamZ5dHdJMjF5RFg0YnVXQzFUWUZ5ZjNmVG96OVR5UG1BSzlP?=
 =?utf-8?B?TzlBNTBvSk9JZHU5QlBYRy9HTHpBK0dCbFVhWDYxTlR0Y1pac3hWMVZiV0Q3?=
 =?utf-8?B?clJNRFJTMHNPWE9xZ042dVpQZTdsR1h2dkFPNElLbEY1dHVKaEFnNGNTRW1S?=
 =?utf-8?B?dXY1Vm83VHNQMnBYL2JRTURSMUJRT1dxR1lzRHBhUGxmNG5JNW5SM1JOd2JQ?=
 =?utf-8?B?NUhIN0FkeGwxeXRqWkE3NHpEZEJqWGdjY3Z0bWZ2WnU1bFR2NmdzQk5RMGJn?=
 =?utf-8?B?bjMrZXhTWmo0WGc1UERsY21QcDRhSDlLRGErdVEzSGViQ2YrNVh5NzVaak5S?=
 =?utf-8?B?UkxHbjF5ckY5K0hZZWRtc3E2VTE5U0FoRnpycG02VUJ6cmthTnljdmN1Q0Mr?=
 =?utf-8?B?c3Q4L2M5S2ljNFUzN3VkM0toZ3RkQ0huRHpuS3VhWkx6ZXJnTVMxYkt5aW9O?=
 =?utf-8?B?ZGZvNytQOHVUV3UzK21LRlBDVHQ4QnZZamVZWXpZWlo5UVBBMktCTm9SeVkz?=
 =?utf-8?B?dm5GTnR0ZGFWZDdMcy9PNTFGN3dhUjc0UVdsT0s5a3N6aWZmSGk4b25ZTEtn?=
 =?utf-8?B?dUZ3WGhMcUdKSlFtVjBZOHNta2loQ2xCZmpHbjBPc3Mvall3RXdpc3FXTUty?=
 =?utf-8?Q?rCa/6NZPrq1z138?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184262f4-7a47-4563-eac8-08db2a173d7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 14:19:11.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CwDR/J2dQlklzPJ+v9pjy7wLS5SjY/uQI4vunzOOp4JIcAxKAM+KbxK/OOQUyUM2Xy+Jy3HGQskRRlYSL/rAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6775
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI systems, the OS can direct power management, as opposed to the
firmware.  This OS-directed Power Management is called OSPM.  Part of
telling the firmware that the OS going to direct power management is
making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
methods must be evaluated for every processor object.  If these _PDC
calls are not completed for every processor it can lead to
inconsistency and later failures in things like the CPU frequency
driver.

In a Xen system, the dom0 kernel is responsible for system-wide power
management.  The dom0 kernel is in charge of OSPM.  However, the
number of CPUs available to dom0 can be different than the number of
CPUs physically present on the system.

This leads to a problem: the dom0 kernel needs to evaluate _PDC for
all the processors, but it can't always see them.

In dom0 kernels, ignore the existing ACPI method for determining if a
processor is physically present because it might not be accurate.
Instead, ask the hypervisor for this information.

Fix this by introducing a custom function to use when running as Xen
dom0 in order to check whether a processor object matches a CPU that's
online.  Such checking is done using the existing information fetched
by the Xen pCPU subsystem, extending it to also store the ACPI ID.

This ensures that _PDC method gets evaluated for all physically online
CPUs, regardless of the number of CPUs made available to dom0.

Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v4:
 - Move definition/declaration of xen_processor_present() to different
   header.
 - Fold subject edit.

Changes since v3:
 - Protect xen_processor_present() definition with CONFIG_ACPI.

Changes since v2:
 - Extend and use the existing pcpu functionality.

Changes since v1:
 - Reword commit message.
---
 drivers/acpi/processor_pdc.c | 11 +++++++++++
 drivers/xen/pcpu.c           | 20 ++++++++++++++++++++
 include/xen/xen.h            | 10 ++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8c3f82c9fff3..18fb04523f93 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 static bool __init processor_physically_present(acpi_handle handle)
@@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
 		return false;
 	}
 
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index fd3a644b0855..1814f8762f54 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -58,6 +58,7 @@ struct pcpu {
 	struct list_head list;
 	struct device dev;
 	uint32_t cpu_id;
+	uint32_t acpi_id;
 	uint32_t flags;
 };
 
@@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
 
 	INIT_LIST_HEAD(&pcpu->list);
 	pcpu->cpu_id = info->xen_cpuid;
+	pcpu->acpi_id = info->acpi_id;
 	pcpu->flags = info->flags;
 
 	/* Need hold on xen_pcpu_lock before pcpu list manipulations */
@@ -381,3 +383,21 @@ static int __init xen_pcpu_init(void)
 	return ret;
 }
 arch_initcall(xen_pcpu_init);
+
+#ifdef CONFIG_ACPI
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	struct pcpu *pcpu;
+	bool online = false;
+
+	mutex_lock(&xen_pcpu_lock);
+	list_for_each_entry(pcpu, &xen_pcpus, list)
+		if (pcpu->acpi_id == acpi_id) {
+			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
+			break;
+		}
+	mutex_unlock(&xen_pcpu_lock);
+
+	return online;
+}
+#endif
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 7adf59837c25..4410e74f3eb5 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -71,4 +71,14 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
 }
 #endif
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif	/* _XEN_XEN_H */
-- 
2.40.0

