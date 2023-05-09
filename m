Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A96FCFA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjEIUgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEIUgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:36:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C7E10FE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:36:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349KM7q1014966;
        Tue, 9 May 2023 20:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uHzwEiKWvOQ1r7ZehfGPB9ooOayjryZ5CEYygTkM3VU=;
 b=bnZepD1pC5SScsc4pIOcqG2JrvYk9ZiFDgfPXayq7amYmlmmMmqv1drAz66rTde3BPFI
 f2/hhJKddYBgGfB681AeW9HZv70mvwbIWeTmQxll4m1FhDyOFlHvOjXtFxOrHP7Zh6tt
 PSiUlQB0r4sftxtQgzZfkVRfm0iSr1Qvxumjm+yt9aWK+V5z8tp7spzm6Bl9rxFcmi31
 aqNKwCbh41nZFhQ2rY8HLNH60Z41XitghcBgUCAl31A++DLBk2Sg0JcNnRkfFMHVnx8o
 Oc+B/Zr3siKU253PjjgqiBcyaMI1dxgWVDG9lH1vVs50GXd22+Pc4U0nzx9yEveDw86P 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dawmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 20:35:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349JuGaH002176;
        Tue, 9 May 2023 20:35:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81ewr7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 20:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVW6wmbilYFVn92wjbjv4RLQUoivVQnv3QoW632KM7E7Fd2fzMj+jhexzHJzjR8jH3jRJgylGOsJJfkgnB2U3Rl9Wpbg4ldGJrbBKZsWi7nx/OS8ju4YM1J4Vq4qQbj3SOcSQ823kYKbNfkPtxF+HkxWry0UhpTbkUU6JKwSQYxTTdouKoilzRKPWjBzEo2DKb+iAyt65bO4odV+rmXZzIXwhokaEPIFW13RqtX8M06cwystQv0dAqrYS3oLDq28bBwQwiN9V4Q5z2qGrcb6i+aNOQadFIcExvI37YAkyqF0FfLWlX/ChLQEiQQiJIQNXpJiRa1LpSVNjoAwKXhHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHzwEiKWvOQ1r7ZehfGPB9ooOayjryZ5CEYygTkM3VU=;
 b=YEgMJMvpEForUnVwR5INmXnNnnzQHUMLpJMf0rg9o3HcF1iTzsWvVuKi9saLNr+2d3mMJbcTx0P71sg81dmSIjUzX8fiTRkMiHfJMer0fsXzpI8vzWNRQarDl5xdbd4mAnuMW48SHBk/aQA6zDJrsMClTeePfJRZizuN9M6s1CD2Jt3tEO7OptutWH5y7/8A0c7c81i/aRdkG6b07xkmyxdx8TWBSEa2hQU/4G19UJEP1fTgrV81Crv3gaWWoOExrZ+5jl2N+CZ+1sHf0B5E+rpv2spZDvJrBf/A8qOhh8gOLtN6v7ZpxhkjMvyHPaw1pR1O8mHRTUaKfqShy/7nXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHzwEiKWvOQ1r7ZehfGPB9ooOayjryZ5CEYygTkM3VU=;
 b=wimT42/KPs1+73dyYwCAE/5W6BLOdxfK5dXJxdKGLYpYuPj/u3f9xRkmIWHYBqxiNK93zdl8WDoBCpg5Bwa5Dg3WsQ3/FNklIF/r58jMw0IZPhwzrv3aG/zhjLx73YmtImOhDL+mSNtloj8HgceZRmhGkF4ixupA5l8fvP6LRzU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB6098.namprd10.prod.outlook.com (2603:10b6:208:3ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 20:35:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 20:35:53 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "efault@gmx.de" <efault@gmx.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v22 6/8] crash: hotplug support for kexec_load()
Thread-Topic: [PATCH v22 6/8] crash: hotplug support for kexec_load()
Thread-Index: AQHZfhB+IlWQGQsv1EKjctAn3JBh2K9RipqAgACFUYA=
Date:   Tue, 9 May 2023 20:35:53 +0000
Message-ID: <b635c9a3-35aa-55ea-6dcf-ff3afddbb65e@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-7-eric.devolder@oracle.com>
 <7e9999c0-c6eb-d0a5-dd2f-7d38c7054ff8@linux.ibm.com>
In-Reply-To: <7e9999c0-c6eb-d0a5-dd2f-7d38c7054ff8@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-imapappendstamp: CO6PR10MB5393.namprd10.prod.outlook.com
 (15.20.6387.012)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4531:EE_|IA1PR10MB6098:EE_
x-ms-office365-filtering-correlation-id: 6c34e0df-822d-4a55-9c02-08db50ccfbed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26z/flfvENC7xPiKQv3NyndhkOIPU0j9xDmtaByHXXyVgHjZAFsKAXlzXZhBG/RGq46GATzM0kFWyrRQLuf/IfEmoDd8dJgM3NKF21+JVV00oYnDHqVyFntjP2GlbpHrqT3RGNEIigOXegd6i8O/j/rDcOP3XXvX7ee7VIodCs2wEsNzow1wX7gfk2NqI41PdmXnF0hBQMS06F78yFz4/5RbtadVE49fdXH60HmjRRehe4cmTPHGQUWc1dTfUWvlbT2DsQJ30WFudxtuUedHehKzZeeCXBkECtbqg3jH0Ccugw/f3zPA+CgPelMEtmlvnGucpEfvBWUnXBwfwBtLE45ZTdo0GRti8uQ3tHtRviv39/6z7fXPp4rFD5NnDCMnE+r5crW3e+t4dnAAGLsoYwfn48HwShtR8f5UXqKmTc/cOzbRDbUkESejmGw64g1Tb7W9YIXHoZfBRQ/criM904vF3VRKvUbB7aRrdNkHbsRmsUUTAP1AMXmELjE0u1l1F5KyemoEfTBPUOnyWzbZpJ/KA72M1RsjZM0wLM2wMyryjzc+iKWVfRxSq3uuKBZvBa4nUKzkBrEuae07IrN5XAfQEe+b2LGogXPKssyMhz02kDd+WX1XVKWom3TuNhW/KpLa3vv0Z5bF5nAnUMlhXhcRFj2/xLNQDjN1o9M4jy7P6+NZ2d7QiaMpjvlYrZPU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(38100700002)(186003)(53546011)(26005)(122000001)(107886003)(6506007)(38070700005)(6512007)(2616005)(83380400001)(478600001)(8676002)(41300700001)(7416002)(8936002)(5660300002)(36756003)(54906003)(110136005)(30864003)(71200400001)(6486002)(316002)(2906002)(31696002)(66556008)(76116006)(91956017)(66476007)(4326008)(86362001)(64756008)(66446008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GFWZfnBbmJIieU71zMLQVQwKh3EKgX4SxJbnzbWa0zthgbgy5xCD/jP+P6?=
 =?iso-8859-1?Q?4+kxRz8ZyNai9TEXRzSYlueoRV2JOgOUTBsB4yjKT6P20Nk5yw95uzmpLH?=
 =?iso-8859-1?Q?RAEtFyU98doDQBec5wINWu/zoZXBdGDvGVw7n6gTkaRvh/zkcMLdfQWiAx?=
 =?iso-8859-1?Q?ovddwb4KU59wnpQ7apJ5fYIA8Cvifg69HvhyC+yNuPW2tXBXLCJbkBeFEO?=
 =?iso-8859-1?Q?HXNXVQIqzs7MUu0cBaChD+XF0ajpzBIdcmzeVoAFX+5WK29PK99e1whP02?=
 =?iso-8859-1?Q?J3dMUYZNewaxgtwiCq/RbxIHEsWrcOJyYsgytbpkuyeLf5Vf9z/8VsQtqR?=
 =?iso-8859-1?Q?putTrxBSt05g6cItp6RKkR7Lthm6d8nbLGzsbTc5Yt8nwTTIe4JVWD5s9G?=
 =?iso-8859-1?Q?wZ7EIDpzfvi2ULSOl4aaYz/dxo2qnsu82HuK3WOeWnwMqZmSFsA6Sc6sSi?=
 =?iso-8859-1?Q?uymvrq/Rri7lR1zsskt1i9yj2nTUHFrvwC9p0bw+LlxXZPVrRqTYPtLTB3?=
 =?iso-8859-1?Q?g3QPzbT8bmHJaRxeJgdPsBf+A1jCij+fVxUyBQwJy4IDmVnSzwCOtyLsRK?=
 =?iso-8859-1?Q?nw1Bquj/QlviXkrHakmdFlVhMYklyOs3y2Wp8UmZLC9UBZGVfLcLE/EFeS?=
 =?iso-8859-1?Q?GBMYc0KB9oJg67hYVtIkTIvsziuaPOdToIPBaM6r0sL4ycfb/mZSd72Bk4?=
 =?iso-8859-1?Q?6Zn8PjDWSGfdgbMNac9PuRGPL9pFcM/BkLHwXu+3Z9zluf4I2AqRqWWP9s?=
 =?iso-8859-1?Q?H66Idr1FLt/urQYtOzj7Nv8kCIuo2mQkGh8DpeDO77S71oIivjSsyuWI02?=
 =?iso-8859-1?Q?scvG7+MClAKMT7k4LrmRAMLFQ6JFhQVdUePn3je2Vr2VHASB9YN9WDBjyk?=
 =?iso-8859-1?Q?EgmF/+6Khi0VLoLgye1AOuV9PTxmwE0d6/1c2MlSMMLPeuFOFG990it6i0?=
 =?iso-8859-1?Q?8wHCsNWzDiAooaPVveGBAfxY8r65r9WNpiT9/IDIBmowclFGRO/yrtksqI?=
 =?iso-8859-1?Q?kskkW6nj12b+Gr1VE9maNpJxgT6qhU2ui1MRhcc9YtC9U9Kog6uCQO3lGY?=
 =?iso-8859-1?Q?GNXEomSHfgWL5BGcpkR5lzXQGFpCf8bWE0p+3LAfDXL60r6VXVgT6ChN4u?=
 =?iso-8859-1?Q?Kq02+gnalUmonBdtwDZ/aKrrfO5M0t6LK4sW5YjTpB47u2ncbQ78Gwnkw3?=
 =?iso-8859-1?Q?ZKt+k7CkCfLtT2CzrDcEVRHH4HMsmsqZflJQexabjWGluKiAoYJjegnamA?=
 =?iso-8859-1?Q?bimKP53/slJpcCYaybDipbyIxjLZJb7YvXIpqvLJYbGdSfInfD2GSJBB87?=
 =?iso-8859-1?Q?sgX6ch7DbP0SQ1gsJcMY18woZ/j6VvOpbcUlG7IlTN/IbgWy3ogHjWF9kC?=
 =?iso-8859-1?Q?VAyn1vnHzBoHFX6s2XxG4pIgw7WUWvke6hABb+SIm+DtbiBGU/qdS0AHoH?=
 =?iso-8859-1?Q?UdjzN31ValOkUPJmz8HCnPCU3fRH4Fjl1grJvRtT27pQiREMmKjQUCzM3d?=
 =?iso-8859-1?Q?FJyfhbaCvsDgGhc75tFgmGbxGTDJ9cQwSJzKwhdM8NzB/YUOLNf7XPMstS?=
 =?iso-8859-1?Q?juq/k3Af8Ohtipf6lo2/3h1nJiYB0g/80qwJn5mZnYWn4cEjlCLHSnMFxF?=
 =?iso-8859-1?Q?XxTNI/AzDMZhG0ePZhZ9MhnkNSUQ+y3X/B?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7EC5C0BF00D26547947B8CA359E7A375@oracle.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?uQuGq9yOIf/Y73oEdgiqT/oHuhD3AmmiVVymiWtAKMNEbB1FUuVBTKzv9b?=
 =?iso-8859-1?Q?WYqmJyIXxlRsrbGLYlV/LuijgW3tCfJdfuetvgNFM6zARDJGr1VxClliZV?=
 =?iso-8859-1?Q?ZTaqeJtfJuBiympxjwZ3wl2eFzYnkpwgrJNqPB1KVXzCxlWZApzb1DoEof?=
 =?iso-8859-1?Q?6CD+alYFkUFXjnAviRaqUcPYSavneJ9PoNzBkB0FPoNxsS3/39vWL3RXxp?=
 =?iso-8859-1?Q?RPaaj+H+KhJDa68slbB/dTCsiTxRN7YbX9395tQT+MoSfQ/zMi100Yiaqo?=
 =?iso-8859-1?Q?lcX8d84mCcF0c7k0hLHAbyIqMrHqUdhwfu06HloIRCmytJt5DuV1ZBU8h6?=
 =?iso-8859-1?Q?DTiUhW369pXuZRE6qCsdXVauQcpbz9rrUv0+m1EVuE025335NSyoOVKGLr?=
 =?iso-8859-1?Q?pAy4UHi/Jx0G4svlge56DeRhT7BwLOveL5In/c8tH1ZlfmX7ul57Aw2EHW?=
 =?iso-8859-1?Q?S+ww6F0tiG+C/schUazItN90Dbgf8k9UlHGCwEeJ2ELCcQfpX4cMwP+Yn7?=
 =?iso-8859-1?Q?V5vyhRGFaVC3QWndh2mChw+q5RvPwcDkwLgnlRmbyjI2LXokx8zW+NSy3q?=
 =?iso-8859-1?Q?LtwVy+Gocc69c7Ulc99W05GeNAbuN3LA8d2J5W5mzzuo6j+YCkGNCCnpuK?=
 =?iso-8859-1?Q?I4b+TjYdTk+YRyC8q7RHeB4iBWzRL7nPtar8nwgB2TWv80Z5loZ+h+Iv4Y?=
 =?iso-8859-1?Q?+EBFpAw5zyJFCCPOeW6gDW7Ekfl3WnYqu/qaL7jqpkuLgeyv92cqw8Qx/y?=
 =?iso-8859-1?Q?jlKa4mFVbGWe4jo737ZjJrGwfpbs7rhgaelmvh0oRPF9eqs/cKQ3O50i/2?=
 =?iso-8859-1?Q?Tdn2uC49tK1I5lHbZwornz2ussYCt1seXjdPuSJhSUq0NFfnWCD1nKS0TA?=
 =?iso-8859-1?Q?0CZCy+V/KWBvtbvkaaxs09nL1cLA/xQSWwDamVKija3cQ8nF3bGR16XNov?=
 =?iso-8859-1?Q?ibEc6CnTXXub1iX8aOD2CQYZXxkVCBo2DRAudYwM4hJMUB3DED7ETRp/2V?=
 =?iso-8859-1?Q?DDUHqLN4wSp5m1+ixhumMzyfLW6j3uV6gFE+6bdLrUByW4+OwwL6vnCg3R?=
 =?iso-8859-1?Q?bH40NWKxVcSSKadxjE8Jy4FueCKXnl2rEfQCnO+qhdlW/aVen7NJNdPJvW?=
 =?iso-8859-1?Q?nWDQA8G1zFie1/hexDqe/T3dJUml3cGYEcDrR5QKEpiCWjwwdUg1lYbOyK?=
 =?iso-8859-1?Q?vp0zbO5HUqoGIhuJFu+Qk2S1ff/WbZHJRhk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c34e0df-822d-4a55-9c02-08db50ccfbed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 20:35:53.2779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EptoIW35XmMcIcFdIbtDZil0fcQdRGaOaqXW7NrlwWZ62rV0qU99UWAhjEcF17YXDGYP4m6TvDjCS1eRP+E5EQBCVg+Il0NHD3PLpezQ/Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090169
X-Proofpoint-ORIG-GUID: J8u5GHxC5Z4zM1ynuZmttR1Bb7CoZFYF
X-Proofpoint-GUID: J8u5GHxC5Z4zM1ynuZmttR1Bb7CoZFYF
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
On 5/9/23 01:56, Sourabh Jain wrote:=0A=
> =0A=
> On 04/05/23 04:11, Eric DeVolder wrote:=0A=
>> The hotplug support for kexec_load() requires coordination with=0A=
>> userspace, and therefore a little extra help from the kernel to=0A=
>> facilitate the coordination.=0A=
>>=0A=
>> In the absence of the solution contained within this particular=0A=
>> patch, if a kdump capture kernel is loaded via kexec_load() syscall,=0A=
>> then the crash hotplug logic would find the segment containing the=0A=
>> elfcorehdr, and upon a hotplug event, rewrite the elfcorehdr. While=0A=
>> generally speaking that is the desired behavior and outcome, a=0A=
>> problem arises from the fact that if the kdump image includes a=0A=
>> purgatory that performs a digest checksum, then that check would=0A=
>> fail (because the elfcorehdr was changed), and the capture kernel=0A=
>> would fail to boot and no kdump occur.=0A=
>>=0A=
>> Therefore, what is needed is for the userspace kexec-tools to=0A=
>> indicate to the kernel whether or not the supplied kdump image/=0A=
>> elfcorehdr can be modified (because the kexec-tools excludes the=0A=
>> elfcorehdr from the digest, and sizes the elfcorehdr memory buffer=0A=
>> appropriately).=0A=
>>=0A=
>> To solve these problems, this patch introduces:=0A=
>> =A0 - a new kexec flag KEXEC_UPATE_ELFCOREHDR to indicate that it is=0A=
>> =A0=A0=A0 safe for the kernel to modify the elfcorehdr (because kexec-to=
ols=0A=
>> =A0=A0=A0 has excluded the elfcorehdr from the digest).=0A=
>> =A0 - the /sys/kernel/crash_elfcorehdr_size node to communicate to=0A=
>> =A0=A0=A0 kexec-tools what the preferred size of the elfcorehdr memory b=
uffer=0A=
>> =A0=A0=A0 should be in order to accommodate hotplug changes.=0A=
>> =A0 - The sysfs crash_hotplug nodes (ie.=0A=
>> =A0=A0=A0 /sys/devices/system/[cpu|memory]/crash_hotplug) are now dynami=
c in=0A=
>> =A0=A0=A0 that they examine kexec_file_load() vs kexec_load(), and when=
=0A=
>> =A0=A0=A0 kexec_load(), whether or not KEXEC_UPDATE_ELFCOREHDR is in eff=
ect.=0A=
>> =A0=A0=A0 This is critical so that the udev rule processing of crash_hot=
plug=0A=
>> =A0=A0=A0 indicates correctly (ie. the userspace unload-then-load of the=
=0A=
>> =A0=A0=A0 kdump of the kdump image can be skipped, or not).=0A=
>>=0A=
>> With this patch in place, I believe the following statements to be true=
=0A=
>> (with local testing to verify):=0A=
>>=0A=
>> =A0 - For systems which have these kernel changes in place, but not the=
=0A=
>> =A0=A0=A0 corresponding changes to the crash hot plug udev rules and=0A=
>> =A0=A0=A0 kexec-tools, (ie "older" systems) those systems will continue =
to=0A=
>> =A0=A0=A0 unload-then-load the kdump image, as has always been done. The=
=0A=
>> =A0=A0=A0 kexec-tools will not set KEXEC_UPDATE_ELFCOREHDR.=0A=
>> =A0 - For systems which have these kernel changes in place and the propo=
sed=0A=
>> =A0=A0=A0 udev rule changes in place, but not the kexec-tools changes in=
 place:=0A=
>> =A0=A0=A0=A0 - the use of kexec_load() will not set KEXEC_UPDATE_ELFCORE=
HDR and=0A=
>> =A0=A0=A0=A0=A0=A0 so the unload-then-reload of kdump image will occur (=
the sysfs=0A=
>> =A0=A0=A0=A0=A0=A0 crash_hotplug nodes will show 0).=0A=
>> =A0=A0=A0=A0 - the use of kexec_file_load() will permit sysfs crash_hotp=
lug nodes=0A=
>> =A0=A0=A0=A0=A0=A0 to show 1, and the kernel will modify the elfcorehdr =
directly. And=0A=
>> =A0=A0=A0=A0=A0=A0 with the udev changes in place, the unload-then-load =
will not occur!=0A=
>> =A0 - For systems which have these kernel changes as well as the udev an=
d=0A=
>> =A0=A0=A0 kexec-tools changes in place, then the user/admin has full aut=
hority=0A=
>> =A0=A0=A0 over the enablement and support of crash hotplug support, whet=
her via=0A=
>> =A0=A0=A0 kexec_file_load() or kexec_load().=0A=
>>=0A=
>> Said differently, as kexec_load() was/is widely in use, these changes=0A=
>> permit it to continue to be used as-is (retaining the current unload-the=
n-=0A=
>> reload behavior) until such time as the udev and kexec-tools changes can=
=0A=
>> be rolled out as well.=0A=
>>=0A=
>> I've intentionally kept the changes related to userspace coordination=0A=
>> for kexec_load() separate as this need was identified late; the=0A=
>> rest of this series has been generally reviewed and accepted. Once=0A=
>> this support has been vetted, I can refactor if needed.=0A=
>>=0A=
>> Suggested-by: Hari Bathini <hbathini@linux.ibm.com>=0A=
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>=0A=
>> ---=0A=
>> =A0 arch/x86/include/asm/kexec.h | 11 +++++++----=0A=
>> =A0 arch/x86/kernel/crash.c=A0=A0=A0=A0=A0 | 27 ++++++++++++++++++++++++=
+++=0A=
>> =A0 include/linux/kexec.h=A0=A0=A0=A0=A0=A0=A0 | 14 ++++++++++++--=0A=
>> =A0 include/uapi/linux/kexec.h=A0=A0 |=A0 1 +=0A=
>> =A0 kernel/crash_core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 31 ++++++++++++++++=
+++++++++++++++=0A=
>> =A0 kernel/kexec.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 3 +++=
=0A=
>> =A0 kernel/ksysfs.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 15 ++++++++=
+++++++=0A=
>> =A0 7 files changed, 96 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h=
=0A=
>> index 9143100ea3ea..3be6a98751f0 100644=0A=
>> --- a/arch/x86/include/asm/kexec.h=0A=
>> +++ b/arch/x86/include/asm/kexec.h=0A=
>> @@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage=
 *image);=0A=
>> =A0 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_ev=
ent=0A=
>> =A0 #ifdef CONFIG_HOTPLUG_CPU=0A=
>> -static inline int crash_hotplug_cpu_support(void) { return 1; }=0A=
>> -#define crash_hotplug_cpu_support crash_hotplug_cpu_support=0A=
>> +int arch_crash_hotplug_cpu_support(void);=0A=
>> +#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support=0A=
>> =A0 #endif=0A=
>> =A0 #ifdef CONFIG_MEMORY_HOTPLUG=0A=
>> -static inline int crash_hotplug_memory_support(void) { return 1; }=0A=
>> -#define crash_hotplug_memory_support crash_hotplug_memory_support=0A=
>> +int arch_crash_hotplug_memory_support(void);=0A=
>> +#define crash_hotplug_memory_support arch_crash_hotplug_memory_support=
=0A=
>> =A0 #endif=0A=
>> +=0A=
>> +unsigned int arch_crash_get_elfcorehdr_size(void);=0A=
>> +#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size=0A=
>> =A0 #endif=0A=
>> =A0 #endif /* __ASSEMBLY__ */=0A=
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c=0A=
>> index 0c9d496cf7ce..8064e65de6c0 100644=0A=
>> --- a/arch/x86/kernel/crash.c=0A=
>> +++ b/arch/x86/kernel/crash.c=0A=
>> @@ -442,6 +442,33 @@ int crash_load_segments(struct kimage *image)=0A=
>> =A0 #undef pr_fmt=0A=
>> =A0 #define pr_fmt(fmt) "crash hp: " fmt=0A=
>> +/* These functions provide the value for the sysfs crash_hotplug nodes =
*/=0A=
>> +#ifdef CONFIG_HOTPLUG_CPU=0A=
>> +int arch_crash_hotplug_cpu_support(void)=0A=
>> +{=0A=
>> +=A0=A0=A0 return crash_check_update_elfcorehdr();=0A=
>> +}=0A=
>> +#endif=0A=
>> +=0A=
>> +#ifdef CONFIG_MEMORY_HOTPLUG=0A=
>> +int arch_crash_hotplug_memory_support(void)=0A=
>> +{=0A=
>> +=A0=A0=A0 return crash_check_update_elfcorehdr();=0A=
>> +}=0A=
>> +#endif=0A=
>> +=0A=
>> +unsigned int arch_crash_get_elfcorehdr_size(void)=0A=
>> +{=0A=
>> +=A0=A0=A0 unsigned int sz;=0A=
>> +=0A=
>> +=A0=A0=A0 if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 sz =3D 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEM=
ORY_RANGES;=0A=
>> +=A0=A0=A0 else=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 sz +=3D 2 + CONFIG_NR_CPUS_DEFAULT;=0A=
> =0A=
> If the sz holds the garbage value we have issues in else part. Or if you =
expecting=0A=
> sz to be 0 then +=3D is not needed in the else part.=0A=
> =0A=
> How to doing this way?=0A=
> =0A=
> unsigned int sz;=0A=
> =0A=
> sz =3D 2 + CONFIG_NR_CPUS_DEFAULT;=0A=
> =0A=
> if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))=0A=
>  =A0=A0=A0 sz +=3D CRASH_MAX_MEMORY_RANGES=0A=
> =0A=
> =0A=
> Thanks,=0A=
> Sourabh Jain=0A=
> =0A=
=0A=
Thanks for catching this mistake, sz is to be initialized to zero.=0A=
eric=0A=
=0A=
>> +=A0=A0=A0 sz *=3D sizeof(Elf64_Phdr);=0A=
>> +=A0=A0=A0 return sz;=0A=
>> +}=0A=
>> +=0A=
>> =A0 /**=0A=
>> =A0=A0 * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr c=
hanges=0A=
>> =A0=A0 * @image: the active struct kimage=0A=
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h=0A=
>> index 6a8a724ac638..050e20066cdb 100644=0A=
>> --- a/include/linux/kexec.h=0A=
>> +++ b/include/linux/kexec.h=0A=
>> @@ -335,6 +335,10 @@ struct kimage {=0A=
>> =A0=A0=A0=A0=A0 unsigned int preserve_context : 1;=0A=
>> =A0=A0=A0=A0=A0 /* If set, we are using file mode kexec syscall */=0A=
>> =A0=A0=A0=A0=A0 unsigned int file_mode:1;=0A=
>> +#ifdef CONFIG_CRASH_HOTPLUG=0A=
>> +=A0=A0=A0 /* If set, allow changes to elfcorehdr of kexec_load'd image =
*/=0A=
>> +=A0=A0=A0 unsigned int update_elfcorehdr:1;=0A=
>> +#endif=0A=
>> =A0 #ifdef ARCH_HAS_KIMAGE_ARCH=0A=
>> =A0=A0=A0=A0=A0 struct kimage_arch arch;=0A=
>> @@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);=0A=
>> =A0 /* List of defined/legal kexec flags */=0A=
>> =A0 #ifndef CONFIG_KEXEC_JUMP=0A=
>> -#define KEXEC_FLAGS=A0=A0=A0 KEXEC_ON_CRASH=0A=
>> +#define KEXEC_FLAGS=A0=A0=A0 (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)=
=0A=
>> =A0 #else=0A=
>> -#define KEXEC_FLAGS=A0=A0=A0 (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)=
=0A=
>> +#define KEXEC_FLAGS=A0=A0=A0 (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT |=
 KEXEC_UPDATE_ELFCOREHDR)=0A=
>> =A0 #endif=0A=
>> =A0 /* List of defined/legal kexec file flags */=0A=
>> @@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *v=
addr, unsigned int pages) {=0A=
>> =A0 static inline void arch_crash_handle_hotplug_event(struct kimage *im=
age) { }=0A=
>> =A0 #endif=0A=
>> +int crash_check_update_elfcorehdr(void);=0A=
>> +=0A=
>> =A0 #ifndef crash_hotplug_cpu_support=0A=
>> =A0 static inline int crash_hotplug_cpu_support(void) { return 0; }=0A=
>> =A0 #endif=0A=
>> @@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) {=
 return 0; }=0A=
>> =A0 static inline int crash_hotplug_memory_support(void) { return 0; }=
=0A=
>> =A0 #endif=0A=
>> +#ifndef crash_get_elfcorehdr_size=0A=
>> +static inline crash_get_elfcorehdr_size(void) { return 0; }=0A=
>> +#endif=0A=
>> +=0A=
>> =A0 #else /* !CONFIG_KEXEC_CORE */=0A=
>> =A0 struct pt_regs;=0A=
>> =A0 struct task_struct;=0A=
>> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h=0A=
>> index 981016e05cfa..01766dd839b0 100644=0A=
>> --- a/include/uapi/linux/kexec.h=0A=
>> +++ b/include/uapi/linux/kexec.h=0A=
>> @@ -12,6 +12,7 @@=0A=
>> =A0 /* kexec flags for different usage scenarios */=0A=
>> =A0 #define KEXEC_ON_CRASH=A0=A0=A0=A0=A0=A0=A0 0x00000001=0A=
>> =A0 #define KEXEC_PRESERVE_CONTEXT=A0=A0=A0 0x00000002=0A=
>> +#define KEXEC_UPDATE_ELFCOREHDR=A0=A0=A0 0x00000004=0A=
>> =A0 #define KEXEC_ARCH_MASK=A0=A0=A0=A0=A0=A0=A0 0xffff0000=0A=
>> =A0 /*=0A=
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c=0A=
>> index ef6e91daad56..e05bfdb7eaed 100644=0A=
>> --- a/kernel/crash_core.c=0A=
>> +++ b/kernel/crash_core.c=0A=
>> @@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);=0A=
>> =A0 #ifdef CONFIG_CRASH_HOTPLUG=0A=
>> =A0 #undef pr_fmt=0A=
>> =A0 #define pr_fmt(fmt) "crash hp: " fmt=0A=
>> +=0A=
>> +/*=0A=
>> + * This routine utilized when the crash_hotplug sysfs node is read.=0A=
>> + * It reflects the kernel's ability/permission to update the crash=0A=
>> + * elfcorehdr directly.=0A=
>> + */=0A=
>> +int crash_check_update_elfcorehdr(void)=0A=
>> +{=0A=
>> +=A0=A0=A0 int rc =3D 0;=0A=
>> +=0A=
>> +=A0=A0=A0 /* Obtain lock while reading crash information */=0A=
>> +=A0=A0=A0 if (!kexec_trylock()) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 pr_info("kexec_trylock() failed, elfcorehdr may b=
e inaccurate\n");=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
>> +=A0=A0=A0 }=0A=
>> +=A0=A0=A0 if (kexec_crash_image) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 if (kexec_crash_image->file_mode)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D 1;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 else=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D kexec_crash_image->update_elfc=
orehdr;=0A=
>> +=A0=A0=A0 }=0A=
>> +=A0=A0=A0 /* Release lock now that update complete */=0A=
>> +=A0=A0=A0 kexec_unlock();=0A=
>> +=0A=
>> +=A0=A0=A0 return rc;=0A=
>> +}=0A=
>> +=0A=
>> =A0 /*=0A=
>> =A0=A0 * To accurately reflect hot un/plug changes of cpu and memory res=
ources=0A=
>> =A0=A0 * (including onling and offlining of those resources), the elfcor=
ehdr=0A=
>> @@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int=
 hp_action, unsigned int cpu)=0A=
>> =A0=A0=A0=A0=A0 image =3D kexec_crash_image;=0A=
>> +=A0=A0=A0 /* Check that updating elfcorehdr is permitted */=0A=
>> +=A0=A0=A0 if (!(image->file_mode || image->update_elfcorehdr))=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
>> +=0A=
>> =A0=A0=A0=A0=A0 if (hp_action =3D=3D KEXEC_CRASH_HP_ADD_CPU ||=0A=
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 hp_action =3D=3D KEXEC_CRASH_HP_REMOVE_CPU)=
=0A=
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("hp_action %u, cpu %u\n", hp_action=
, cpu);=0A=
>> diff --git a/kernel/kexec.c b/kernel/kexec.c=0A=
>> index 92d301f98776..60de64bd14b9 100644=0A=
>> --- a/kernel/kexec.c=0A=
>> +++ b/kernel/kexec.c=0A=
>> @@ -129,6 +129,9 @@ static int do_kexec_load(unsigned long entry, unsign=
ed long nr_segments,=0A=
>> =A0=A0=A0=A0=A0 if (flags & KEXEC_PRESERVE_CONTEXT)=0A=
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 image->preserve_context =3D 1;=0A=
>> +=A0=A0=A0 if (flags & KEXEC_UPDATE_ELFCOREHDR)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 image->update_elfcorehdr =3D 1;=0A=
>> +=0A=
>> =A0=A0=A0=A0=A0 ret =3D machine_kexec_prepare(image);=0A=
>> =A0=A0=A0=A0=A0 if (ret)=0A=
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
>> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c=0A=
>> index aad7a3bfd846..1d4bc493b2f4 100644=0A=
>> --- a/kernel/ksysfs.c=0A=
>> +++ b/kernel/ksysfs.c=0A=
>> @@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj=
,=0A=
>> =A0 }=0A=
>> =A0 KERNEL_ATTR_RO(vmcoreinfo);=0A=
>> +#ifdef CONFIG_CRASH_HOTPLUG=0A=
>> +static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct kobj_attr=
ibute *attr, char *buf)=0A=
>> +{=0A=
>> +=A0=A0=A0 unsigned int sz =3D crash_get_elfcorehdr_size();=0A=
>> +=0A=
>> +=A0=A0=A0 return sysfs_emit(buf, "%u\n", sz);=0A=
>> +}=0A=
>> +KERNEL_ATTR_RO(crash_elfcorehdr_size);=0A=
>> +=0A=
>> +#endif=0A=
>> +=0A=
>> =A0 #endif /* CONFIG_CRASH_CORE */=0A=
>> =A0 /* whether file capabilities are enabled */=0A=
>> @@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] =3D {=0A=
>> =A0 #endif=0A=
>> =A0 #ifdef CONFIG_CRASH_CORE=0A=
>> =A0=A0=A0=A0=A0 &vmcoreinfo_attr.attr,=0A=
>> +#ifdef CONFIG_CRASH_HOTPLUG=0A=
>> +=A0=A0=A0 &crash_elfcorehdr_size_attr.attr,=0A=
>> +#endif=0A=
>> =A0 #endif=0A=
>> =A0 #ifndef CONFIG_TINY_RCU=0A=
>> =A0=A0=A0=A0=A0 &rcu_expedited_attr.attr,=0A=
