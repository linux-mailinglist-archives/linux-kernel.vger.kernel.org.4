Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF0735A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFSPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjFSO7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:59:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F2127;
        Mon, 19 Jun 2023 07:59:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9nPcr013012;
        Mon, 19 Jun 2023 14:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=30AvlD9epsOlbL6Lxr9q+X8J9eI+32+6pwADDTzRalk=;
 b=SXKDAGZTbIYWKZVy640muGKcHVc7P1s/jK4BeC2TmQ6d4Jc1H4jwPyyLrY2EWvrhB1av
 gJ7VylG/fZqpB+dz9bfH7Ej3YvzEnh8jKXbR0dheu9L0OhFEHS72EqAbLJN47sYmJg+P
 ZwigeRYuiuH0o802WGh+erHHfDy9TbgDDWPGoMpNwehwQQnhqyq92kLv0Fzosuq7Hhxj
 bco/N4I/QF6Xzsj7PoxlilPwJmY1vqh3K9to2ZKxJMk3BtdZzagFqUDzJQjZ+HmcqPz3
 2VkcLp3fCHUyTtwgZnaSwVWDn1DvgUiYdGsiXVsN0w/2+FEVRa5fp8udjPR5HD/stZ8K ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbjy35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 14:58:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35JErbpn007838;
        Mon, 19 Jun 2023 14:58:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w13vr2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 14:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+oOykqr1DRoCspZzggPcIgfdSHkMTMoFDMm5RXSmfIE+OuaK0Tds7XbZzwl4Vwtz+Vgq42TuaSeU355vEiSvz7NH3RFIo9smDdGRdSpZpQoN3IMvfHqPdlMsbdl+fVIuWfvP6nofsSDLhHkwF87t15EH7Q+CcJi48zyp+2/0S7m7dbNPdTXs/jvvbnnn+Pdxc0MgKe4oySWfAoL4gOGqXPrasjkIYERxQ7yRAF8rRxIZ6Mcr366sEYIOTxNjdJdsZEhsKk2rIDW1sw+XAzt2FNaaUj2JajCsz6rMgr3oAErnCDMuoCAu9umOGsHBVClpUUws0p+peKH0BgCdT33cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30AvlD9epsOlbL6Lxr9q+X8J9eI+32+6pwADDTzRalk=;
 b=EDnXD0gtYcbw5s/itHrVFw0oAJaNkT14yBGKPb6IDapmRuX/LIpYFppsNWKDO5tPa3XphqCE04Zdey1bd0BAm6QgHCbfT2apcUn+JuVQm7/SCUt86m+0/5akqn7BrgqdurgwD70iBMma2AB91dXb106uccfhX+Ruky2kUGhpWfY68Ckrkpih7z/VN7Svc757uulpngdj0xUsJV49yTGvDsOnhoDvrNBji3OtKeCyCd0cuNt6jTU+exaxdDrzTAZDxZOTBTieINXUA/vobTGQxVVKkA2f2/P0UnVUZvyUZ8MikvhL4kTkm9uzcRW895seLn7R7jegmg64em/BBbSVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30AvlD9epsOlbL6Lxr9q+X8J9eI+32+6pwADDTzRalk=;
 b=NgNBDvwZw5AHqu0xHj5hd+BCLUP9l8OB2PLEY0WVm/j3js1fgBoBUOJiWkqfDcJ3L7chKDwHr1cJlL0gP9PJBuZucrOvMRJgHrtwUEaROoHmKm98H67mwpJIc9W3xP7YdwC57K+2c5jSNNF6CTwFIuqOh1aSWbb4hrOzTlfOqaA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:58:35 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:58:32 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Cc:     kernel@xen0n.name, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, peterz@infradead.org,
        frederic@kernel.org, akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        eric.devolder@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 08/13] mips/kexec: refactor for kernel/Kconfig.kexec
Date:   Mon, 19 Jun 2023 10:57:56 -0400
Message-Id: <20230619145801.1064716-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230619145801.1064716-1-eric.devolder@oracle.com>
References: <20230619145801.1064716-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS0PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:8:191::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA1PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: cad63e27-d5f7-4462-41a0-08db70d5a651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUidkY4b+OUYkL3VVpoerpe342c1Y1S2vZoaUSOUYGpsmupXW/sxE6eU5Gt3QOHC4v2mUG68kApumi7i1+NtVEJ51Le6KxPgw14CaoXsDU/K/BLBJgBp4dFwzUfhwLMBg1ccrUioxku89srf6MozBmt3lA/MnPn9TLiu4sO6XAg52GUSlEgNsZuhh/wgteBfqmzVW/J5dfd1d4XJvxPeCObvrGEzrmSQJaVnCZtgY/oyAPSb34qf1miQkvON+0KQuIgGAY9nOmYRtiWYkfenUD9/zj2Zay096nnjzlVGFex/eidupOAvMxHbY4cxZJ4HTFlNK2iZuxrhceMLGdTAden9uhSTDY/CU37YRZCfy7aPgP0uSz0q4EOCrap1XzkBYb59j+Kj7i46OHoYWoD8MG9yfFBtDr0oBCETW6yfhQW28KffHQhcwzmkiR4NGyaf7DOZ0XekJ5+J9YROI7ZH9/X0ie2uvhZHbW0VsJwZTOov8v3FcqD7Q6YhUN9xGUZOUngOPpPpeOa9lc0TQZDi+vKlSuoYpKWBkbAdpSIw/jmQVXIa6jpTcklNQm8N2REChYPbFbqaawZtS+XBaDfCW5Tkb2lePn/NJETZhs9u5zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(7416002)(7366002)(66946007)(7406005)(8936002)(8676002)(66556008)(66476007)(107886003)(1076003)(26005)(186003)(6506007)(6512007)(36756003)(83380400001)(41300700001)(38100700002)(5660300002)(4326008)(316002)(2616005)(921005)(6666004)(6486002)(478600001)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RvaQXnWQqqPf29uRyQBpf7R5caXcw1yYxOgmWw97pVrsInu3J4RQfjjr48D?=
 =?us-ascii?Q?o9ax5uLBRR+DWqYjK/5b5OlycHvYCz6kiNPc4Fa4AHcmBs9GgDuX0PxqgaFZ?=
 =?us-ascii?Q?vpQAS8Aw9USqMydvOLnnxPeeNFirv5hmppJ3oYCCbWH8OVtfRYiPcSOMz36+?=
 =?us-ascii?Q?Tjgsql9d1yr+1yDmmPG9I2Md9wTT3WtPl5EveqHTMvHGNk+POe2AxPPRU6zC?=
 =?us-ascii?Q?ayBKjlQ/fHEkYFHCqPtVQ3dceZ8jtOug1WLsbsRmh5eRbO/0jaZghjJ3s3Ym?=
 =?us-ascii?Q?VZSZ3FXUqb7em4OUjo6ebJGRgh0KEYRzf0/fuYWFuM+tWqD9aGmgDDC+oOIQ?=
 =?us-ascii?Q?Ib8hyea9VrjYp0BO1tE41372+/3+P7KEugQLjFyTbYk6WNl84Ik9JnrV9//p?=
 =?us-ascii?Q?ktTo7AT/vez6aYVQYJG9yZZjF2ovRUoZFyb1vJej3sBUiE9+uWoSdB7ZyBXi?=
 =?us-ascii?Q?tXx8Y9Rk4Ow9xiM21Y6RxNczTfWrwYCRA+gqoW9yjidpH+aygDHk8UZ8SPDB?=
 =?us-ascii?Q?DMdlG/L1oDB35pEyASmg+3q1+yUHGAkQPOGnquTNIhu0ALhB5V33UDzMgQn9?=
 =?us-ascii?Q?9qVPCzpahGJkY6sgJ8Z2ZYPecxgFb8b7Fu5R+7EbOQuBvOiKxqBPAiAMXwHq?=
 =?us-ascii?Q?RFGfBdUg/z5i+q7OTGiWhFkqPl07x1zMvHAQiSAT5LxAfodGnZAxkpc3jXaO?=
 =?us-ascii?Q?oDwPQUj0UtlSZteblD1ZJh+hCUlDvgEEGb48a542lFKcVxmooFumwjMREDkd?=
 =?us-ascii?Q?xby3wLTxb4/gcJswJd4tZY7U8CFW3ypoZfTS6PcTxNB7Fn1zkFASdZKfyiNI?=
 =?us-ascii?Q?Q5HX8nhF8Tp0S5oFWaCN3H+Be2Ka1pBJ95MvlsYZvYCf74aIr3AWx8YAwUih?=
 =?us-ascii?Q?/tdx0v3NZJHKdvIMvxyOooG3vHWgLdmtxIqvihoAl4/m/qav5+ZO0ZBK2zRy?=
 =?us-ascii?Q?Gf3Zi4jSNosirN0f2q/0xVijdGHDiCJLeO1VJNolnDNNS0VOSys44vX0jECs?=
 =?us-ascii?Q?zDzQlHmRABTAwtwoje8rFLQa9bwABAlf0WLnjJOyH62rHE43Ckg4ZYRMs6vq?=
 =?us-ascii?Q?IrV3ccjeeWrfwfq2/Mvovhdrzsn1Jvp9Ml5LiMZPSgwzfUjC1MwmZfA5lTaG?=
 =?us-ascii?Q?fW9dvh8avaWanLBlsnpnegHyxlo42nS0AcQ60PDX1VZriwCmHwAls5J8CWb5?=
 =?us-ascii?Q?wbcmX5ieQRXvWSYeGjo7wm79bG6nDkUt9bQ1nHUa7N3jR8E9FroctmW/ZOyc?=
 =?us-ascii?Q?uFzO2pgRJkeJG4NdKyL9zlhfS1Tb+Ud48c4y7D5LNnGzGrvSpmVcnhcqdhGy?=
 =?us-ascii?Q?ntJCJL+bAzg+wR5kZYCbWpNfcSMSM1bAEL8rOgLfmvNppAhd/zbIsbACrbgh?=
 =?us-ascii?Q?2EML4GCpRguJ9tA1K6UBI7wPQQDz+UbOn+1XIILywMkSj5qtlugjzhm/JN58?=
 =?us-ascii?Q?b/lGENLURtXiBeWLlIdkGCDx3gu8PS2zMmZZd2HjC97lUoiN/IPiaJGHUcLm?=
 =?us-ascii?Q?g3dhQZcI2Zd/8NSZmyMRAF41YSnishyt8o35sMFVWDt1H76/v8B/O8L2uoGc?=
 =?us-ascii?Q?ulGvdAHdQ6GfvqTyWZdqcoNn42wrJhu+YNqfEY6wCcF11cwd7BclCKpyGtn+?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rOA1z08WRfMXAVRKNI4lGb50KaT5KLzz6fEgc6V3WlGBfCp6MKwa6vglTgCz?=
 =?us-ascii?Q?6CjlfaMEvGnPatSmU8z6HKuaJCLAZhw4V3svF8Vxv8i0a3GkbkLBUWcsNOd6?=
 =?us-ascii?Q?SiKbJ88TWvCPvnyZOHFpJExKWC3eqs0wJt8M7pUsemv7Dyba79mwxRoxh/LA?=
 =?us-ascii?Q?TaQJ54nwrpBnu9NfCUM1hF2DKC3nt6BCBZJPqmvSp6DY5KwVF727MOnXeKUS?=
 =?us-ascii?Q?5D2bBTsxA7hE9ZBgDNmay2DVMokdYpOwXwsU0gw8bPeGTs58iKJ+rFgwsr3Y?=
 =?us-ascii?Q?HwmdpVYh7cGAg2/Hx8AYydPxbBfbX2sIqZElsBXDcuGIyI5sDNUT4CkS3f+5?=
 =?us-ascii?Q?iQIE96UxcHkNfZEt7trb1oBA6dGABSGz1xUmVk/IPbyUptejN4zmcwfCmSCx?=
 =?us-ascii?Q?uuCRQR9MsaclFvJByEzD8BMeMKnQNn8Rl3fTm6FMdXZ7A/sQrH1Yszd7AzbG?=
 =?us-ascii?Q?oHmN4GGhXi3oNe/h7UE4gitcrT34sdsq46fdEfmBbccpmZ576UYTWYkDbFSH?=
 =?us-ascii?Q?AKJSWR0ChCdGnAcX/BSgeIkwOapTRIDj1ZQx6isKGpWWyurD/dEEcg+I3XIn?=
 =?us-ascii?Q?3ny3GBBEO9jctompP+NCSPG6mFRMcER8CkHnHCYLBMgEJkI9BknNxTRFlVAH?=
 =?us-ascii?Q?gINM3b9kpwuL8kadOKBvlNkYoemDSbAm8M23aGsPGSKR8KjwjaGpmhfYOpex?=
 =?us-ascii?Q?11HR1OmA9glH53lzdrtE26jObUCazcpnsW87sWjs3rufxAAJWDi76dUfkHCO?=
 =?us-ascii?Q?X2PS4wvtDB57mMYpWE2LQ+O+rjv237MFfl/+qxbNgTQX0Awwh66xQxUc3XPm?=
 =?us-ascii?Q?2Q918QtXrTK9BFKMuBhKjnr/3s1xv2l+kWnmTngHoOBHviDgjflMqQgWgKaZ?=
 =?us-ascii?Q?ryAQtjbaBDDMhNmjJUA3IvzZ1AoqjepQBGPE6B/HWQrmJLZy+stOpU8YP8BV?=
 =?us-ascii?Q?TmR3sCWfOsw1fDPb/UIKxe6y5gCrZflsJtqEBDmt5rJDCLlIArzRhQIRYAYR?=
 =?us-ascii?Q?U0BYnMi2g3hWO+gNyKJX8wW4KlutfpxEtS7NvIMCJdXJrZeQQUmm2mMgXZ8s?=
 =?us-ascii?Q?6gG3rJu0FIhqG5ootkNOhnLujT9OqZA1L5gdRZwI80epuOqtiZU0rTMfppMf?=
 =?us-ascii?Q?PidsE2adikdA+xBLoJohgAPowGq8UQjVxBJ5SohGP/9Lb48YEWvUoQGFxXmx?=
 =?us-ascii?Q?TuBU+VAI/Or+IIq5vqggfxKk+SfquWhADngsjP+o5c9cW3mAifzPWA9Y+BFp?=
 =?us-ascii?Q?njnpU51KxY4/cPyTJbU6R6tC/uT8wpQbbnQhcfQ6oTeSTizRf4nk88+Ic3oA?=
 =?us-ascii?Q?G5+c79LGF7u0Y1CsImla1UzhcCLZZnQLDMud/vd77POGc30ypufZnwJsMGqX?=
 =?us-ascii?Q?DUU94BaaSLRQ9h4SgBbX+gpZkFbbGVZZJY09TpqYDPCOtppNPgVQd29ZBDM4?=
 =?us-ascii?Q?wzFLxKOqlFjXnxSEG82o58WYwzgglKxM0xCAI6+zhbEErFxcYM8dNtReAepl?=
 =?us-ascii?Q?w2ZO+RNaQWtHWHraiCS1bZX8jXasWmSVqmeLBxkS6rEbo6GECWPZbL+3fxag?=
 =?us-ascii?Q?44/s3oqyqpyQkfgCpQlmvHmom4BSi2jAaUynFLy44MdX7iQU3gI/GchKJxTU?=
 =?us-ascii?Q?yWK0ZtsigPCc0eCihGykB2f7CRq8ZHc6lWlEXdcBgyNYHpOmrvZyPYjonDbc?=
 =?us-ascii?Q?bGLP0I78G3ox56KJ6+CQrdHsDrMtSGkOTpGHVtwHGw8cOjrGXpu7yimQZrK7?=
 =?us-ascii?Q?wHqMHqQYqQ9do6TpMJTyNLcCoLeCEl8sqCZq/JJ/6vhkbAbrGGVdpdyw54H7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: cLZj6aK4odyRWulnXaElVvrLmAlzjvYQz8TJcYCEijRdoGtAm+C6wUy1XI770U5Hkh/8uvAqPtbfmdMi5Y0WOJQYTAZjuNo6Hze+yajSYG+fwFDNhha8N7sCw5lDik7WgT8HdDwX/QttXOGVL51sDu6Z0GbFIdAacHq4T3BdswRuCuIKm9dhknejZwg3D1ghESWnMI56BketZdB4uzABT/tlav3bNVByYXigaWn7Pz9cj0jpq86+M5+6QYlBCxW++XXZTgtdYlyQs4HlmVPocssYWKR4p9BfsleF+JgxHKY5/FTRYNAyQDZrMKW1BE5uDf4r+SFzdeLey5AMcS1uhkKXy1POjQqMD51VRwsz7oR4J63MziDzVDIow7+IFWPquTqLz5RkCjsrl4+XjcQ98dRH4duFTeEqgNJKB3Siw89447aUNUJn+u5NAqMTITSBbT2Vls+qkU5znA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad63e27-d5f7-4462-41a0-08db70d5a651
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:58:32.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExMg9QN2SRPaGByYoD0uO7O2YH4Pv6FlVgNw2HUox8owuGyjXbxVzD938bYqhnBT3u6I9R52FBZrXWXKOFlWFpdxC3wMNVAOnmwV+SqEZqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306190137
X-Proofpoint-ORIG-GUID: zRrjVQGKfKv4TFwJEanBRejPqi4FuWXd
X-Proofpoint-GUID: zRrjVQGKfKv4TFwJEanBRejPqi4FuWXd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kexec and crash kernel options are provided in the common
kernel/Kconfig.kexec. Utilize the common options and provide
the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
equivalent set of KEXEC and CRASH options.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/mips/Kconfig | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 675a8660cb85..3d9960942cbd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2873,33 +2873,11 @@ config HZ
 config SCHED_HRTICK
 	def_bool HIGH_RES_TIMERS
 
-config KEXEC
-	bool "Kexec system call"
-	select KEXEC_CORE
-	help
-	  kexec is a system call that implements the ability to shutdown your
-	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is independent of the system firmware.   And like a reboot
-	  you can start any kernel with it, not just Linux.
-
-	  The name comes from the similarity to the exec system call.
-
-	  It is an ongoing process to be certain the hardware in a machine
-	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  As of this writing the exact hardware
-	  interface is strongly in flux, so no good recommendation can be
-	  made.
-
-config CRASH_DUMP
-	bool "Kernel crash dumps"
-	help
-	  Generate crash dump after being started by kexec.
-	  This should be normally only set in special crash dump kernels
-	  which are loaded in the main kernel with kexec-tools into
-	  a specially reserved region and then later executed after
-	  a crash by kdump/kexec. The crash dump kernel must be compiled
-	  to a memory address not used by the main kernel or firmware using
-	  PHYSICAL_START.
+config ARCH_SUPPORTS_KEXEC
+	def_bool y
+
+config ARCH_SUPPORTS_CRASH_DUMP
+	def_bool y
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded"
-- 
2.31.1

