Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0E72D2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjFLVOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbjFLVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:13:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC1187;
        Mon, 12 Jun 2023 14:08:11 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO2s5029142;
        Mon, 12 Jun 2023 21:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HSzcNdlJygzAbc0ZvnOKimbjFfFfH/fTWMiHEhLyWts=;
 b=bja8m4Is+ne9VGH97LRdVKlQjgle5SwdvCjpTaqX9RR2zmYOKXm6n6zmjbu+PLY4SxH1
 6MwhyRF53Ot2imnEodBV09/gEqaWnlPIeAMHuRdbL8rw6cy4udNNDFUYcnlZvRgWV+Qb
 Ymy6tVst0Ug13Bb3NGpwN24PFVScCTvjkTxI/dsPRvDFFqqjCNoaApnlxZYRlniMM209
 ggfGqZODDWUbs7ElFYkQ0ckrBHe0o7eAf19QLWqpJQHEwIKI9et5oITvCua5H+Axm8du
 bNV4recklW6sir3IXV9OLc09BmpTI6KSuMf5GngbB3WqjMA/5rNeWQTMpnpKH7XIVI3M mQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bkytb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKTajR021673;
        Mon, 12 Jun 2023 21:07:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3a84b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE3qu9q3cdyUYZXAwlKPqdILXbRxa5xfiC7jYVcEzaOJxWQB7GwK/tE5GYhD4nKCHlJ+qP8zaCUP9UqCqPPdrCVc4Lfd3M94A7pexz7gEBBn9SirsjaMEiwX5FufqU4BdOqbUxdrRaT+ytRhI/XDcJKhEBcZsEU7dROw1J/UlcGt4aJx3MSJJEOH4aY+sf/jYEQn9wZOvwzSurVQDe00H+2yu5ApHd92c02tZlKObhkAFqKg5PXNCjY36BTEFUWZVV4mx5TNOMn9NyNomm2zcTMdnGthBqfNDhIbVRfBEjLbK+oXdX2CGMGiRBjJflJNPBYt2wuuOKsdLKgSRujIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSzcNdlJygzAbc0ZvnOKimbjFfFfH/fTWMiHEhLyWts=;
 b=Wv3HQo0MevxC4qw+nH+J6rxl9fHt3dlvqABCe6a5YKEJGDNB4qRu+1glPeZDQoJ9GdGq8qL5d/EL2TlnHWMS1JDmbBP/ArNsNJfAEvtEBXCHVEFTW66ielIncAOOQtAD6zFHsFyL3GmeqMKufXuFUA2/3xqF5UDisR7qqL4pbOzrnJD9IaTh0hfKJW64awmnUyrHWFDYb7Lod7f6Vc4DA3tz8ufEpNe3HlKh/YYEqjs2KijGYiwcBe4Ihuij3i91O6N1ZUk9GmaHXQRcjwN0Cv70Sv/OXWFKIVVqnqFbiZiU83mtLjQsMGjaN+wRUYWMU5i8Le7BVCVMocp4WWGJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSzcNdlJygzAbc0ZvnOKimbjFfFfH/fTWMiHEhLyWts=;
 b=vYd/qi19o/fAp6n1FzfxzmkI19N1FRspIb9atdJsr7RzL9d719rz3EQNlXXEzrSHUHH9QfpCODu5iTtyq1irubbN5KCg9VnVOyJ0FjZpmoUk7uk2xzcv2HX+lO50GdLP2tQScixJrOcidgU6AgKb+yuxLnm1AnPPFSeiYFj6/Z0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 21:07:31 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:31 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 1/8] crash: move a few code bits to setup support of crash hotplug
Date:   Mon, 12 Jun 2023 17:07:05 -0400
Message-Id: <20230612210712.683175-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b6259c-0c87-47bb-29a7-08db6b890918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dU42Ufi1AmbhuRSfus8kFGgWIVZdnC5QVXRsCJI2Zmi6Bch2IeLEtrYitotJeJUXTmOm3NT7ynLGvl4G3ZLBVTM+QYcQD/blR+dUEtEIcvkVd+RF6x5lxcfpirTMHAiRUzKSgv84aQH6zZUUcs8nGBRgjoEhfodmepijkDzVx2a7QvCCHjvfXpmh6mx4IzOo0FDmBGOKxfHowkYR8QsqJTHfS5ZZjdcI1MWBqCsZbtjAQJ+8OKTfQI6IAi7SbECvrwofDE1xj3474usZOA0AwVI/gctrMkIm2DnFESm0nZtIYTAGL8EtUV5hUfZchM4Z6QN3D3I1kuJbJb1aQ4vinRIYyDLG1MrzAfvkNZwf/xqIgSmMj3xVgFcWGHbpfvSst5UrAjZIkp/2zOpppZMaKkrVcEaC08BGEVSkoqCYsub1Lld7Wqf5286V9lJ2pVHh/RBt7kimnl7FR8EbY2snfOSVdKpYy7AEmS0EPILVbQ9v7yBr6+xwb46KpnajN1dBR1igSRgeIGhU1TFcTH5RJIaEYwQjcey41gc0ORE18m9fSgzH//bQLXLdwpeApJAi1BlEQVYr4j0XaEAyvkUW4R0ajdGp0WaTejvxltVnqTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(86362001)(36756003)(30864003)(2906002)(26005)(6512007)(1076003)(6506007)(186003)(107886003)(7416002)(7406005)(41300700001)(83380400001)(478600001)(6666004)(8676002)(5660300002)(8936002)(4326008)(2616005)(66476007)(316002)(6486002)(66946007)(66556008)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/xX4H4a1oKa7oMWwheYsOmLHasEADguDUZjekPIslXTn391STksXWD1yV+b?=
 =?us-ascii?Q?Eha+olArPEtS8r2rcdO33DDOb2GFjEy1OLhkpYfbuGppDFhoAqMpgoEaG43/?=
 =?us-ascii?Q?7DUm/iBuzITpFgrHO1IkFtW2/1IcY/qbKJe2Bg5ojtDqTqY++/nqJHaa0OHl?=
 =?us-ascii?Q?t/I7EzLlBHgRXGaS81BDptU7bQWjw7y10BEve2IqsyJlKHWgtqkwyrE1dKcc?=
 =?us-ascii?Q?xUC7Ox/U6mTqExbQ/31unUjo8b7npVOfLPn9V6QIttLiEmCPglgg7LjvjK1Q?=
 =?us-ascii?Q?7unVcSHZ+cWAA9JQi/Hpw8ZKEaVwiCKN9iXSo3cHlpu2iBMn7BWQVUbjOBCk?=
 =?us-ascii?Q?K8FYAPpO5KNgVllgVS4tZA1Hia+O49PjrK+rXS8klVtHDiCGnUnbt4qejOe+?=
 =?us-ascii?Q?J3szoZOJkcuvl2nqzmflwaZ7wtUQw09BPs3rhru8oYtQUl5MzyFxnoTTh/fd?=
 =?us-ascii?Q?LpsFXPd+mcJWc1LGJPHgnfkHZCs0uJkGA3SF35QbiI1zLNdt0mT/GI5fHMMo?=
 =?us-ascii?Q?0oz1nBLdndI5yHZCeLVlXwppgAjnOpzUjsHs940wOQXH36+2ip3j6ox3fvkj?=
 =?us-ascii?Q?1qTVx9QQ5LR3cgIh6RoSEgjRIRjVkoyFMlczcdqjhm9CyVy4UgZcxhqlw3NG?=
 =?us-ascii?Q?ENrTxJ7t60do3rGq6NPKi7C96nuE+tfFJiEv5lTe4hGqG5Pt4sjdIZnT5z4m?=
 =?us-ascii?Q?L5Upj3dOxbS2sS8GRZvvTx0NDp+DGXESXsaHpgMEG4+Lfze7ftzVHwPqYBNt?=
 =?us-ascii?Q?dw0Yrz/9qvIO8p5jKEoVPaPzOakrcrpGkU84+GStrzLZEcaIs1u6UzWR0+fk?=
 =?us-ascii?Q?cGnnG8f4SBEYtWZIiWe2IuDwKcYt8GAQOGdl7dxzfDGuDzihBdigkAG1NsK2?=
 =?us-ascii?Q?SHj5bPFU+jd7wj495RccPp8c5N9pNy18zR1MUPOuJXDSDrL/GD73zwPOgifP?=
 =?us-ascii?Q?7zNGfjvh7jpRlRitCqVlGubUZSbb/qMI2gesmgvpMKdIO6w2FD6nysI0xs1B?=
 =?us-ascii?Q?pcqgTeVMJvPAqJTfuSddKVICBQENiRwRkYFFVEX1mYfB2G9B8ahuBvDPc9Un?=
 =?us-ascii?Q?50GdVLK6Pdq94oAXiBKXV6HH8wf0EjgXoq5CKzQlzeJF3MEtaufe5hdWCy58?=
 =?us-ascii?Q?RiJaAv/11yq7kNia0h83hm9GIxfl28wQqcvPGr06/qIrAccAVZMEQKkegro7?=
 =?us-ascii?Q?ySZGwOI7Xjo6XkuKnWXDxGxMAHuCvLFEua20l7MJxncbL9so0gCc0HPNX1Rk?=
 =?us-ascii?Q?GRaoYv9dMEY6JT7ZlRO03HE6wxfigGloOZjyvEGoHnLfjpI2uBqjcapd9+Ou?=
 =?us-ascii?Q?ayG95Bvdk19D1JkeYvPKozVfR8Kn3ymC9NCGwT2fpiv1YQqzN9KQ6ifaiiBx?=
 =?us-ascii?Q?3zPtUr7EVLUQrU0lMGvfP4Qsk9ELeyx7i0o6i6ANGe9v/vnpgu/5HP3McNeR?=
 =?us-ascii?Q?mRM9eaQnH9vzh3y9cSGBdFKNlQfEz5e9ZljZebRIG/cK8vKjI2l/S7wEReSa?=
 =?us-ascii?Q?P2DfZgHwx38/SFGT1dBaP+8ZoSpNaieu3dzpycS35jz3a/580t8jRfnL7GEA?=
 =?us-ascii?Q?lD/4LjnqkFA//tiBmbkkfl4KOEC217sdk+LD2hmzylNWRZ/GHYVvHumdyCmv?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?N32FytwrT5p6tFGwH6n5L0Cfg+i+Yx4cWAROGjIq+R9ONie9GRXoim30Mb9N?=
 =?us-ascii?Q?RlBWei06JsVF2Equgc7hyMQ9gY36gS0iA/+1HPpPwQOxw4p9lCe2U5jHvBiP?=
 =?us-ascii?Q?MLoF8OPZR9140rv2i5MBbTWVZ+UbrD2UDv2c6lxNXLz83BynGP157yxV5an0?=
 =?us-ascii?Q?K7/AGIK0fw7eNPlEo48GYgQQrDwxKf5yHvj1qcz1ZuiTqDGQBO/iE/jw5P1B?=
 =?us-ascii?Q?79nNk/3+ILef956Fa4+iwHsWA2U9KTfdMi6JxfwNRDDOs0VDgwTp8n/SGhZ3?=
 =?us-ascii?Q?itLKjp6fcX4hd9qA9Ype4jUyCmz6Visnx5b530rCKGD+mDmu3dbADEN8ozO6?=
 =?us-ascii?Q?1OAKbqn1l9q1z2H0aqC+vKFXRHxYNHJOYdaQlCOeSMc5C8EfLtrkRrNmCKo8?=
 =?us-ascii?Q?DRzD0yyNfV1G3bC9XsQDKIZB79xoHt+Lcmm6si6Ua2SDiu2V0rGO7YefEwdA?=
 =?us-ascii?Q?0i/gi5c5+gvXBymMbtRGSQbcls5oTSWsw6LQWB6/SEWtdFwoQ6XYednDPCay?=
 =?us-ascii?Q?xkVEA0FEgtqGsXhj6Og5dGIBrWXtsVe0zci3J7uGpeLsXjCaN87E7ow5gps1?=
 =?us-ascii?Q?WnQwaH8Vyuqp8udvazmIs976ykzu3PU730cNRdGciKI+ZtkaO5IFuONnwZDj?=
 =?us-ascii?Q?js62DaVIy/eJiOjkDcsrYZA+BLrlYlwy0NVJh6oguBiPmuzaz7/SEbsbpqUI?=
 =?us-ascii?Q?Zl5UfKlejxBSQn76OXm4joRejY0eE8G1ehH6h2Wwx5ly0WLaQfi4g6MMUbMi?=
 =?us-ascii?Q?hKSQS0zwK+xTs+6+EtYrTlUtug4oqD2Hl1JbqXnhdvIhR8sSh2EWGjUo8+4J?=
 =?us-ascii?Q?ZV/9cXQiulPeqWmiQ+9UE+TeZRjEm6itlnb6D92FU3ECMNBCWMWknaa0/BWj?=
 =?us-ascii?Q?dwEmMgbMkglceM9k+N1Si81/hiX36ASo4RZPC+i+jHC5zLRQrLoSojM9GlP9?=
 =?us-ascii?Q?kvxzw7qXDOziRNXxQVN/DXH2fpxtOe20ccFxPxkEpdtKkKLQAum1GHvoNAqg?=
 =?us-ascii?Q?zXJYUsZkxV/11Z73T02C5gHLnXNV14syQGlx+6qEfwRij4bQFYtTnmjxwJ6H?=
 =?us-ascii?Q?stSNWP/q/++wBKtFGOCREsg+M84QC1/Df5UO66VauNHU3lhhWTRjHnquuMxg?=
 =?us-ascii?Q?7F+LFjby1s3up5K30DEqcHYFFnqvtCCLQu6D6pksVzVDFJTT8n2R4iUM3utz?=
 =?us-ascii?Q?nCDgPA4G2/B/m7I7kbBG+ukVX7URX88bgAo6/lorLZldWOoZuwDPY6wonUAv?=
 =?us-ascii?Q?g6iehihUU2/eGunxA8YC+esq9LTorKlCyuitBHYKTa+3VJORdR8nllXOrmoD?=
 =?us-ascii?Q?9pQwQ1Zj5cfsjEW7j6BG+6nxJmIIaEVulUxvSEFtThBW6tCuu2Hwb6PEl+Rc?=
 =?us-ascii?Q?WthsLMvtoM4B2FQ81EjwdcOsre8XvpnpJ708nVD+pxBWfycPhQOCVDZtTY4C?=
 =?us-ascii?Q?/Ll4OAzqbHI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b6259c-0c87-47bb-29a7-08db6b890918
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:31.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g/ueBZAMq7RmANweoNQYgbiwHAIRH6QlxgabEj3FAOa3H/tAKRgM2t+z344RJZDTM6Gs1/jTBl/yYvm+TLhlk0jXaPckC1rL3Ts8Y5BmFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120180
X-Proofpoint-ORIG-GUID: EVFxPqTm8TNvzGcDQai4qDUseDJhFpjY
X-Proofpoint-GUID: EVFxPqTm8TNvzGcDQai4qDUseDJhFpjY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..811a90e09698 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -230,21 +245,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 90ce1dfd591c..b7c30b748a16 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..f8b1797b3ec9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1138,184 +1138,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

