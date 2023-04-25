Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134B86EEA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbjDYWQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjDYWQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:16:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD47EF5;
        Tue, 25 Apr 2023 15:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sox4xdF+DQGR+VXw01qFZC6TARAH1JO2CKF79fVL2Ul5I3QnbxaW5tocp4Dodj4+pIC2ZKUDKutDst+tpxWP9/XwbQ73aTKMWwctnBq9Zc3qa2kVnaJ6eJ5T1KKXWlMMSn3o5ZddPypdeGwNw49X4GXmOzuW1rFyKxYmXdMSVmkcN/uB42yKo5c3qnuhZol4lYf/1v6R/gWE88QJyJH+rlIa3F60DJGNv4a0WXzTM40qQK6qy7bZUbFAuNioSLFWe4edSIQKDiv/tPnGya1B1xFFuvhB4Z9BqfGALb3eA5rzKWSx4RlfCx+eO4y27AdQ6My80JmD4HJ1bGFads9zOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3WvzAfUeQ14pF82R+8KulT/O+KMgtqYYPHCPkbuGu8=;
 b=kvvRVma807dgCXo52V6dtW1UoW1f1s8ohXK3jQfaHN7W02Wdx2GebyzgYl9zqky3zoMib60kpYN/si1jjq+Uubg3YWhvMW5YKLhxqMcj5u21wjEgdlYUH3ZKwqkdGZRVK4yDmFB/AGUwnlt1HrJBrEVJUPSGnqwSP/2s2D5AFq55KSNAeQZ80sRCY4G5UnWznFCk4cdpxhIALX/VsThH8IGBW8flw4rNNhUZiX6PBVMMbR2ERTtBn9tkMikz9YN1LXS/vj97MhQAa+8nzeEIUTJaLWX6IBnIySK7c5AzOh4gEBuTuxAFK/VlBMfJfnROHzzVz9RAQbXUEYrkAHg25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3WvzAfUeQ14pF82R+8KulT/O+KMgtqYYPHCPkbuGu8=;
 b=hKXqEo3Oyzw1GLk2zGPzVXw5YSf6WHgeH3Ouhibh2/RZ2Krhh6haPebf+k6LTzWaXzpHPgsEfZ6sITxlAxXwpZjb+RxSbM5PZXAlh0yYyOi3er7E6/HGficl8Iv4nQ0Qyob3w7BRNd/6yJpnm+HslzSOwBjtX8oaACz6M9YMnfU=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.28; Tue, 25 Apr
 2023 22:16:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 22:16:33 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jonathan Singer <jes965@nyu.edu>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Function of the camera key on windows
Thread-Topic: Function of the camera key on windows
Thread-Index: AQHZd772r7Abj2wQYE2xqXleeNi57q88l6Ng
Date:   Tue, 25 Apr 2023 22:16:32 +0000
Message-ID: <MN0PR12MB6101534DCA26C99BE06F06CDE2649@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MN0PR12MB6101D9688E7904FF52634520E2649@MN0PR12MB6101.namprd12.prod.outlook.com>
 <20230425210953.14597-1-jes965@nyu.edu>
In-Reply-To: <20230425210953.14597-1-jes965@nyu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-25T22:16:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c0443289-cecd-4dd4-a396-bb8191ead4a9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-25T22:16:31Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9d20a956-e5a5-4d21-b688-19cb38695b3e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB7912:EE_
x-ms-office365-filtering-correlation-id: 2b5be525-ef37-4ae8-11e7-08db45daba18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D081MkabDN2O0LeMEJnByo9xIrfh7iuM4caWZvalAdKaIELYWqlKugGsgT6Qu/+AaHXxwF+vlPOXgradPECPerFd9pGuAW1ISSe6gtIPYeZ0asm5Kl6psAID97g4u6CUyYQOesfFJh0BtvdPaw7yL5UXob9lzY8zS2lxyfgRG+RO/3W0f2ExA1UaG+WHBi8ppKI8TrA3WSe6u3+O1SnqZKm68LyeCmaiWe/I4639MqhuwjqFB3R7zIs7PvtYA7FYTfowJ15laFQycHjCCdm83tQiM59ci5E72WkxqdzX2h4TH8Rk554bxbT0PtE47KilNwgFmJ+PVu//iVV38FH6sGV4ZrFBQEeWOMC8CFBI5DHqilZVcb8mpI5cuqjeQ8WomWgVH1SGTeX8+Nf1anA5dSx6KKKKo3bnfobLM35QrVih0xk+YlZ3Y9PMCXzCW8BTta26IbqtNS90HR/0iRLhQaFP5XT6LbuC3nPb0mF5LKtnjm+2JW1NcMXJYU4hSVZxAmylx9bA5olzxxK+8gDnymQYjPUxUuaDJMnMlB2ZqJnE0O+srBLp+rlVuOp2UGnf5b9krSHgEJWtpVJtub+EVVt/IEBHDkWx1uepeoB+yY0H2Pf4AaQVok8bE1NSNsrY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(66946007)(4326008)(66476007)(66446008)(76116006)(64756008)(66556008)(478600001)(83380400001)(33656002)(186003)(26005)(71200400001)(9686003)(6506007)(55016003)(7696005)(86362001)(110136005)(8936002)(52536014)(5660300002)(41300700001)(2906002)(4744005)(38100700002)(316002)(8676002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KzKcYx3CPS/rhzVzLWXEdQeIZ/iMzPCrk59IKbFZpODm1BFYkKTWi7coiTET?=
 =?us-ascii?Q?+ga+gLHyBDMXVDqNN0bDyAM3G1GRSZ4cuU6ldUxAadwjQ61CZ+Bp6KZ4kE3g?=
 =?us-ascii?Q?qbUvJEiKv4Gp+zfE1ZEBXC6N+3ZTfNHVgj+c2W4R4wn7XWqwHow+DzUWqetf?=
 =?us-ascii?Q?5jyegdAQT8PMwYVu1L41jipjwmJi07t+4w/RFwt5Eg5x5ayIArSdZc0pVdA6?=
 =?us-ascii?Q?NCEyLTOdmfFaGWzO7M+IdH321bhqJk45Yk1hVbM5GFQWF7Q/gcxxcF9HvBsj?=
 =?us-ascii?Q?J8vu7HDwuSfQElEvizM3zL4R3SlALJZE8nI+yyry/ZPvawURIDbV2b4ZvUhw?=
 =?us-ascii?Q?r3VWenZprwHdEbh6Ec85ADfdHQh8M2bZdUvgGQCK7C4t2v+TGXcT4e/TO8IO?=
 =?us-ascii?Q?wC1aR8xO3v94duI/+FrXlgh6fFkOQsew8hi03fnODbuU5n2bduGKYkUvygaT?=
 =?us-ascii?Q?IMM3oF98dDdtjPQ0/dlk6MOLh4FEu1emwSPiLtmmPUXa9aGyVlO8Aw+oL4xQ?=
 =?us-ascii?Q?MS+oWxGSnRcSE6cUuYfWVhr6dzldefBZP1D8dZNZxpYt21WHCXJwoFX5Ejqf?=
 =?us-ascii?Q?3aCOClqEZZyipMA4t+LMgAeRV0FvHEIDCZDIweJ7nR1fpcfb0GOBPpWMdbga?=
 =?us-ascii?Q?7cSidg5/WZ/adpQjJ05WZWToeBXdP4MR0S5/lG4eR5QssREiZPBkC23Kl6g4?=
 =?us-ascii?Q?BK8rMQvt71yyCgOKr+G5mqwHEznFZEcKUoYEZdDrbAfPeIuGdona5RLynmCo?=
 =?us-ascii?Q?GSswnoIp7Xt0HnCk5QUapF6PObfVfIQavfjJmNfQNj7lbQoityMQYLZZORZA?=
 =?us-ascii?Q?oY0zlHlc3EtKCSeZYH2GaWFiuJaHh09447Pci9HHTpcc+5zK6DMP+TvdyERF?=
 =?us-ascii?Q?YvrfWGEl+LUkXBhHhH5JbuySl/bQSUntNoS+LPR+Na4fKBhrry0sVoON5ZN7?=
 =?us-ascii?Q?VsBZ+L1G2bhAd+HOC4+at1G6ljCbQTTz6c1nj2ThALws+scl8QTzf9cW2Hse?=
 =?us-ascii?Q?TFqxPe3vviRG5Ok7HrPPmU0Pw1/7qDqrs5IpUSdBrogKCZySNNM379niAhvP?=
 =?us-ascii?Q?JpJXxbtMbY9Mz44DlOUMJswqWEd0pDNEvtTPQGOuz038spoeshoqdJ6Uu3bL?=
 =?us-ascii?Q?jKFdygmwMPYMY0+gvk3wUEq/dPA9d7CUNOljPD0MVGOXGEFd4X8fJzZTPbq9?=
 =?us-ascii?Q?q0lSIiK84Kc8pEtbgeLrxhAgtRND/4f0yKoivEtXclpPGlQlS57EkXeilTPU?=
 =?us-ascii?Q?nmGgwKuKltaPFdpxcqWi5ze2wXl0/JB+PRn2e0iehCAOgtZxXaOLMVC9HWHy?=
 =?us-ascii?Q?8Eku8P+hQ+Owe7RVaFOB+8LxzNRp/dj4UZb4oz/l81KuJk0DypypRGR4F80m?=
 =?us-ascii?Q?+/AoxdDWBK0h6pJwz3vCIDsUk5gRvw3nfPc/oeFaW6erWv0n1qZoEDpMmkMj?=
 =?us-ascii?Q?C5MtTyk7r3mKA1IKnt00O7NYmTlP8dBqKLgoKOoi3clSatqCw57T+qLqZ60R?=
 =?us-ascii?Q?SNQDP5Yi4pt8fo7JuIKWhK1G1clNzyjd6oWBhkkCig+XCwX4j/LopF5tfsWb?=
 =?us-ascii?Q?eTIQzqFonCT0EhfVeGM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5be525-ef37-4ae8-11e7-08db45daba18
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 22:16:33.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rznSHXiQHdFh3+xFMh/E7W9CH23riPuzwl+UdO/1ltTJauDspGihbTZZbeO9tQN35hkeLwN0mr1LMJ7+R4CBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> The key itself triggers a hardware response both on windows and linux.
> It disconnects power from the camera USB module and raises a cover in fro=
nt
> of the camera aperature. The keycode is as far as I know only to notify t=
he
> operating system in case it wanted to show a message.
>=20
> Is that the kind of use case that would benefit from emitting a KEY_CAMER=
A?

In my opinion it is something that for example GNOME could pick up and disp=
lay
an image with a camera with a line through it.  If it comes again it could =
toggle.

This is pretty similar to how mic mute works for example.  The way you desc=
ribe it
I think of it as "Camera mute".
