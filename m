Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04A86BA544
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCOCe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCOCez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:34:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0333222E8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:34:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F1cPPq020981;
        Wed, 15 Mar 2023 02:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=fojwjoghvBaaKFtNYXr7wNpQpL93nLufW5rQGBkm5yE=;
 b=sIkPX857HIHTQ3RaSX5yf6/spPMfiUfottiz7cmwFSXBnXsXmj2nGI5g+Lzn4Y8gT4Xb
 U9tnDAc0ZNIv8ujUpot44DdO1qfrzBZqBD2VG/G+RHYIxRIM3urraNg5ggnxLMXR78Re
 FIbIA01SIfCt7DqeQ6l/M/6wj/RTYrIU9T2/xEt9HKCCDvG4RPj3KAbQdpVNh+bC3VeI
 t2rztYgR5HjXlI+YAPeXxOAFT5JmHtln0AEBXtG6LfiEWo/LUW17t0ORQCqyy7gwlN+0
 zF3kQ4WGhoODv9hkVhlAQ8z0NO9dR3Amp0kq6NRNI+PtAlEU5ST9ye0ukuiYB2cDx2pt OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pb2u30763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 02:34:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32F1UsHS036464;
        Wed, 15 Mar 2023 02:34:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pb2byp55n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 02:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3mt6r8H0vdpvLGpkhCiyhSqWjdmS/wjkB8sOiaO7S9Yp7LnxzJdZbqhBcKABRvp8She+77BQNqzE/pZ2AYFzjvLs/UWfyMZdVS6kB9fVO5otPPNMNXf/KJ2G4lxQ39LVBHAvxdfDgmjS93Jr3WjHNMojxp3cH1JR/5lXgCB752YDqa1Oprbfc664STFD9Nu4Y8VfbdjvnjXbHbec/W7Lq8/Oc/Ovsy5TCDFUILj127a+RNO/3de0Ep8V2JtfG4f02kAPdh5A/b6CY+OSEYccLsKP6d84Mul/hGlp4iso0RWvNT47508bNHr8yAKD5eZ+/Tq8GvEi9o/rfBKuU9b5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fojwjoghvBaaKFtNYXr7wNpQpL93nLufW5rQGBkm5yE=;
 b=h3jqbnOCix+NrkEF043K0/OSmTdHpx67gxrY+BdexFKUnHxokBUr/kFjLox8aBw2yWHu4Gl0z6/hYmxqnYj/VQr+up6x3PDXTJCjm+xSGx7SGQ05akgeE2m9D0fEGt1cyCzl6K6FcA+hIug+EqEMLhUVkdXM2MUafnfYZuI76TKvljqVvKlTIevckOVnlGcNPlAQ5+ulJ4w04EyX0sboUR4Zr0yT4hp5fqPTjqmkRa14PAomz4OOLvYh6Dr7LDlaTTKaJOGFalZCCzm4Oh1HFdyyGZfjzWjDKVEpX789ZVqY2EZJ819444RBqQitVs2gY2DuvubPeJ1EGoGR71EsrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fojwjoghvBaaKFtNYXr7wNpQpL93nLufW5rQGBkm5yE=;
 b=p68aZPVqyTq6GWosL9X3b2tx20d5l5UdDxTp08sSLePT0sureqEaRWfQaeyvuTOJsDudnCRJngD1vxiybuz/REmWEZubYHXAC17xpH2RgSlejjlLZM8XqvoAwoQsL8sJ/LHD8o6VAGiCbkb0tDZpM/st0sZP62lQ/fnjIX2B6Mc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6292.namprd10.prod.outlook.com (2603:10b6:510:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 02:34:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%9]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 02:34:00 +0000
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alex Shi <alexs@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Eric Dumazet <edumazet@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hannes Reinecke <hare@suse.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hu Haowen <src.res@email.cn>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qlq68x5.fsf@ca-mkp.ca.oracle.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
        <20230313182918.1312597-23-gregkh@linuxfoundation.org>
Date:   Tue, 14 Mar 2023 22:33:57 -0400
In-Reply-To: <20230313182918.1312597-23-gregkh@linuxfoundation.org> (Greg
        Kroah-Hartman's message of "Mon, 13 Mar 2023 19:29:05 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:805:106::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e945a2-4795-482a-7484-08db24fdbb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQmfocQzmBbmq36HFAZxSQaME61SsFSFhZKC8kKS5EgX6CdvcSt8fsQNJJFJkYTh+jg3oVeZez4uApHjpiogYk2004O9n0cX2rRYttkSGSaVjQnYSBUw6K+GTkXu4qQ3jjZ9Cye1pnoMRXqzEfPhNVcoek3OzZVMWk5vxfND19Qsz91FkrlsiJR2iYk9Se/75+r+HT7Om2dY+9iEGlg9N0dwL6uIbPEpKCsgUdUYb/kRN90gKY5QVZ6S1WP78b9XSmIgXH0ThTTyx8PS9DngDn0raez4/VHQjcLkGPg22MIO0J4CdpWr5ompYtYmSdzaXAbF5I6hGw1Oubh9x7vzaFasLGLbNCyxtwXXd3tHont9uPG10fZF1d6L9aCmWFkE+Tl1gYTWEejPdVHuTC00UsN9ibvAHB3taLLFGZ6HlZo5WPTbIMWZ7+UOwxsE2M/Vw4mU4FFF/g16QZzL/mQPlbDdJ7fwyUPqL4dz8FcO00YPn2q7oVcVnJ+TRggZ3n8MzkxdFZ660KJaOyz+XZWBcjUWfH7O8Pjhht9yTOCfawgZIbuyzt3X+uxeM62peHAegl4NsaREMHyACNx+4tP2FV/k7ZD8AJNtc8IuNxAAhv3cWPz5WecNsYEQby9MiUC9mXMOVyyCn80Cfb8+4DTWPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(186003)(6486002)(36916002)(6666004)(41300700001)(6506007)(26005)(6512007)(66476007)(8936002)(4326008)(66556008)(2906002)(6916009)(8676002)(66946007)(7406005)(7416002)(4744005)(5660300002)(38100700002)(316002)(86362001)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HG/8jrsICkQ0wUbcI8qhXOuTyN7s9JGI1X9SGnZlfwNZCrAHOfKqk5q/CJFJ?=
 =?us-ascii?Q?D5axyonhkXuZGlm5AHVfGZF3lrrTEuklrjCpehzSGWEiJRLT7ie4liXSX2xa?=
 =?us-ascii?Q?xcdy6x0qp/vpZuHXwgi7ie7ikByKJnnY2wolbH37ro1N0YWtutlGVMcyX26m?=
 =?us-ascii?Q?MZrheNhwO9FpmwUjvKHXJFq9qFVyAbkv+MqIhN9X9+c4XND6hMWCtC0tHLpg?=
 =?us-ascii?Q?wZgDnw5cru7TfNl8Fus2Pkj1vayiBJQ2+e0Alc0Y+uzg6FXgrMD28G0M4zCS?=
 =?us-ascii?Q?eFOKYuaoxboclHzBDA5wC+pvYCDAKZE6s7xDMTBgkK4ZS4g358wgqwx1Uaby?=
 =?us-ascii?Q?mD3DQ2Z682S4BiksJc3ibykvSpcNT9IAm+UEq9nc0qbyaZxjMgwjxOJkVhIw?=
 =?us-ascii?Q?o31vattm2tXhFz9RxXPHEnLbNlQ0ZGcjHQT7jl9OcGJkTHsKdl5OQ1p70BAA?=
 =?us-ascii?Q?D8zrCg1Jwz2j02VTSxxbaOtxBlpCiY8yUZwCU9+Zf+YcjXSOARRPS+brQJjh?=
 =?us-ascii?Q?LHfz5YI6sFKFYcxeDoDE9Vn4PG4S/NLqIWN7zVAqVoT74iCBiQyHMYGRKcn9?=
 =?us-ascii?Q?mEGXFlyTYOmBr7KqnAB80CqTCi02c8naAyMaZLxoWAHi5jYJpGuTErVTeoYF?=
 =?us-ascii?Q?fRD4dIieX+b/ULfippNEEHDjmilea4PNLhFitRCpsFe7RN6CmVRjjLBLEOeZ?=
 =?us-ascii?Q?1YHZJd9eNEv0i2bIVBNQ67PRsA6aHPEHvBehRcaZM3E3jGcpLNgYZmXNiLNA?=
 =?us-ascii?Q?qSqa/H9DQsozEkGb8i0jcvq9iIFO6Q3gWnGT4ggZcPkbL65xC9Im5fZpk5av?=
 =?us-ascii?Q?QxRQE6Ad5fZi5qWe8SHgT63ij6cBgovlUb0f2rLusscSMCKv6iZMA5wqsWlo?=
 =?us-ascii?Q?6EmLZCYDiBYrMoD94c7TlzOhkLFgQOc7gH8SiV7VDp/OmAknAk+LNkrDkxH1?=
 =?us-ascii?Q?7D0oE1lmugR+DRxTuJTVTEDzUA21wavWPneUsJ4//SszxBwE7WLnMtff7mKq?=
 =?us-ascii?Q?b+q9QBwdz0A+Q3yIKPz/h8t6xlcD2plwNo91wVfvhdHAj5SAzYXidPRDY53f?=
 =?us-ascii?Q?L0x1nvgWw1fCrYwK16zHM24VO/kEZ78L7fGTKH8ZZ2F58U3dnTnhm8zuBtfD?=
 =?us-ascii?Q?+CCAwIZW1bPVjwwFhNUm9iH0TLYcEFlN9Ie9p1E6Z7ZMBijMPZNdp7hxUpvh?=
 =?us-ascii?Q?myc8pOiHYbWFQRAAypD5Lk5obBwz9xIrpYRj+WatAfEQKG4FfLXsMAH8N5US?=
 =?us-ascii?Q?hDBejWJV/aDMgKk7s2StG7E1tcchVQ0XpD6LSLwHJNi31HMq6af9oel+/7Nu?=
 =?us-ascii?Q?1z59Cj6NmEaH9ZtiQv8T74AcfEJiZMqJIRqXa80fXKK82llzimpUEUz+CXyz?=
 =?us-ascii?Q?/xwKMjkwPVA8Sjj4DHPgdNQbSvoiVe2lFYHTfmFFVKu01dHYaicgqxSadAjC?=
 =?us-ascii?Q?cghAsmQPaz9M+qAFrF3ZnkW0/9ZINusYbjY8mU5gc2T+ePjPLFRZJo208WQs?=
 =?us-ascii?Q?cmkaL9oQ1Of+Nr3hmew4S6Kd5u1r6ZaPM0WpXmloGuoOmcl8YD5WHum2OIOG?=
 =?us-ascii?Q?k6BT5XRdakA0uPXfrGGi49jpISpVHAJkJDr5jmQN2flQ7Eo7AJuFhDLTdzJx?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aBvbqmeBe0nYM0er9Ly+3+0WhFxNtqqZ1oJb/vhX7B6vnaJ/QoS7xpeVVZYX?=
 =?us-ascii?Q?WwhZO8gC9ncHcThDE7/lycuzSyRJfO463aCRGxMa/dZPe0ZVcgDq5B2v5kj4?=
 =?us-ascii?Q?GgoNHiC1+RRT5x8NOmysds1K6V9RPyd8glMrGGdl5DIzm7kZSS3eJxeVthzM?=
 =?us-ascii?Q?lxuRpEY9TDv8+HOeq9LkoH7pI6+cKlYs2xULqgfk8UoOLDJAcNjA7ixBOc5o?=
 =?us-ascii?Q?eB57kAkwHD9KNXxwN4tRgcPuotjk7XJilr6+jeZsIOh4uCRRf9q7PnQdGoLe?=
 =?us-ascii?Q?8FzATEWduz7aaz7O+JqFeBdSuAXZaCW4Dkj7AIS2Z4N2DAabKCfFvO3uHpx1?=
 =?us-ascii?Q?CWnhF3rAsP+PAPyXgZlvV6tOjYzb0BH1tOsOsP/jxtJlZhJt3yMLRAZ6b3TZ?=
 =?us-ascii?Q?5ABJNj7PswWP5j74rMGW0dUQD6yPY/pmrvPlCVPXpWdxxOS6k8D10zYn0SqX?=
 =?us-ascii?Q?SSqkt8wi2EPpSj/WqI8KpcpuMkqReUGOs/4M+TlR/4NgZBwCkHAoLTK2kb8d?=
 =?us-ascii?Q?606yJldnzvlpR6BKdXYvtudy3upaZBCKTr8FmfXRaUUY2oEAegOkIhqi4EW8?=
 =?us-ascii?Q?DOXpr0cJH3Bx2QYLyvqScWOs2M5tnxomknDTq8Q4hOgoj4CbRHdh/E8fkV0F?=
 =?us-ascii?Q?3ZcKI9Q2o9cVvqs5cyYZyl0hYftZOHrbfRMjDWi2yrpJgYTnhDdFDNlJL0Rw?=
 =?us-ascii?Q?QTzlE/0JDZNRVMpNvDiKSrJWddoG9BEK3r505mBWF5IgxHdzXMHXUkBlhPui?=
 =?us-ascii?Q?w1GtgkzqPFohRZGkXdFE3Gnt1JsF8JOVMDPt6NcP2KjB75mqmdyHRI6FtyMT?=
 =?us-ascii?Q?/DzSDwAUmoNuGteOw9sS6iTyYGSWi/5xUuWhfIH5F0+vOq+u2ZOFHX9AAQ/r?=
 =?us-ascii?Q?D8Rp3Be2ObED9vh9KtgWFtj+jGRqY2M/9vloJwkBeulckJzl7ydm76kTmPnb?=
 =?us-ascii?Q?DwMNsC1p2TByAAwPpq3/bQ2HfVXCC6kw+2HrRUqZ6gZ7BCeqiepBsZy/9SuN?=
 =?us-ascii?Q?Ns4yIPYvoa/PwIw74fUYm14dpdaK1FO+Qa+Hf6DRPH6Jo8jOP2QzWcxPT1U3?=
 =?us-ascii?Q?73KfehrAlwyaK3f9KlS3VRLFwp/U6Hsp4sMpEAfQMgSxsLYz0OJeVLdV3e4t?=
 =?us-ascii?Q?LuXG7R9XfcGrH5DBc7C0YVpW35XeF0erCLYSGwePNdSU4FFuYModCi7Njipf?=
 =?us-ascii?Q?XcBAds8s3ZRZa5WMPTREIaVgQwNypGbabhZX1PGetk+uMj0nGACdE0Gh0+KE?=
 =?us-ascii?Q?PWnEi4/I+SNoHJTdEysGHtBIkCEAVqVdhX3QEZQ5QXj6VsNz8ebZimEgI95S?=
 =?us-ascii?Q?/u4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e945a2-4795-482a-7484-08db24fdbb7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 02:33:59.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZrWPk3bL5NwoUJLyHsQPNBnEGPznbvavXV5aZBJYnWpKJN2uVcoZz0M9pvgKMyCIwosfo7MqM+0F4N+tzE6+wBWuklqI6U7wLGMyiFNtKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_16,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150020
X-Proofpoint-ORIG-GUID: 4JAfoCR29WxjuNjZhdWrSkxoRMG4C5nx
X-Proofpoint-GUID: 4JAfoCR29WxjuNjZhdWrSkxoRMG4C5nx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

> struct bus_type should never be modified in a sysfs callback as there
> is nothing in the structure to modify, and frankly, the structure is
> almost never used in a sysfs callback, so mark it as constant to allow
> struct bus_type to be moved to read-only memory.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com> # scsi

-- 
Martin K. Petersen	Oracle Linux Engineering
