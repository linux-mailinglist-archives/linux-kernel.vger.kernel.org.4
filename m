Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C060B642
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiJXSxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiJXSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:52:33 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D272248DC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1666632833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OBf5iH04IB6LpL1AZHt/qQEG78BHFOYBu4nXeDYqywE=;
  b=iILGCL+yf1eYAFLNtYd7zkbnqoU4pR/DQcv/5uqExiVqpV9OsOErb/CZ
   FL/UnRUmPbAadvz1R5EWPYBgznt2/UBR7MAD57XMITA7ZE/fZBRbj0J5x
   Np3URLLXEd9KcBaWoV6DByGlNXgDZXibhSUeo+f4IbEliZtbBUmsJcEDq
   g=;
X-IronPort-RemoteIP: 104.47.58.105
X-IronPort-MID: 85922227
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:/ZBQxKyHEI1zQ6+QP116t+f9xirEfRIJ4+MujC+fZmUNrF6WrkVRy
 zEZD2+PbKqOYTP2edEjb46z8xsG78DdyYQwHQVsrCAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHPykYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFtspvlDs15K6o4WtC4gRkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIwvepPMUZh9
 tkjeGo8TAGKn+CR3uuHc7w57igjBJGD0II3nFhFlGmcIdN4BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI9exuuzW7IA9ZidABNPL8fNCQSNoTtUGfv
 m/cpEzyAw0ANczZwj2Amp6prr+SzHmhAthNfFG+3tJbvnihmnIDMQctS3CloeicrE/gZs0Kf
 iT4/QJr98De7neDTtL9dxy+rmSNshMVV5xXCeJSwAOC0K3P+C6CG3MJCDVGbbQOtsI0TxQu1
 1mUj5XoDzkpu7qQIVqG7LqZrjq0JShTN2IOaT4sRxEC6tXop4R1hRXKJv5pDqezh8buEjH96
 zmBqW45nbp7pcUCzaO6+XjLjjitr56PSRQ6ji3MV36l/wo/fJSsZIWz6XDR9/FJII2eSx+Ku
 31ss9OD4+kIBI2N0TSXSe8QWqq07eyMNTTagHZlBZ4o+z+q/jioeoU4yDR3PltoNIAcdCPke
 lTevytW/pZYOHbsZqhyC6qUM/hv47X7FNPjcvHSc8oIepR1XAWd+yhibkmVmWvqlSAElaA5J
 Ifeas23DF4EBql9ijm7XeEQ1fks3C9W7WfSQ43riheqy7yTYFaLRrofdliDdOY06OWDugq92
 8ZSMY6GxgtSVMX6YzLL6sgDIFYSN385CJvq7ctNeYarKwZnMGI7CvLewKgqe8psg8xoevzg+
 3i8XgpUzQT5jHiecQGSMCk7NfXoQIp1qm89MWo0J1G01nM/YIGpqqACa58werph/+tmpRJpc
 8Q4lwy7KqwnYlz6F/41NPERcKQKmMyXuD+z
IronPort-HdrOrdr: A9a23:LPnCT6DEu0qfnkflHegPsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U0ssHFJo6HiBEEZKUmsuKKdkrNhR4tKOzOW9FdATbsSp7cKpgeNJ8SQzJ876U
 4NSclD4ZjLfCBHZKXBkUaF+rQbsb+6GcmT7I+woUuFDzsaEp2IhD0JaDpzZ3cGIDWucqBJca
 Z0iPAmmxOQPVAsKuirDHgMWObO4/fRkoj9XBIADxk7rCGTkDKB8tfBYlml9yZbdwkK7aYp8G
 DDnQC8zL6kqeuHxhjV0HKWx4hKmeHm1sBICKW3+4gow3TX+0WVjbZaKvi/VQMO0aWSAZER4Z
 7xSiIbToZOArXqDyeISFXWqlDdOX0VmgLfIBej8AfeSIrCNXwH4oN69PxkmlGy0TtegPhslK
 1MxG6XrJxREFfJmzn8/cHBU1VwmlOzumdKq59bs5Vza/poVFZql/1owGpFVJMbWC7q4oEuF+
 djSMna+fZNaFufK3TUpHNmztCgVmk6Wk7ueDlIhuWFlzxN2HxpxUoRw8IS2n8G6ZImUpFBo+
 DJKL5hmr1CRtIfKah9GOACS82qDXGle2OFDEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiIA/nZ
 zQOWkowVLau3iefPFm8Kc7gSwlGl/NLAgF4vsul6RRq/n7WKfhNzGFRRQnj9agys9vcPHmZw
 ==
X-IronPort-AV: E=Sophos;i="5.95,209,1661832000"; 
   d="scan'208";a="85922227"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 13:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODDwyf9zr+RH+7QCM2lHAFfYLX7kTGZi8MGrcIY/hW/SCt+ySO7GpAMBr8n8fpM7FPaYyf/7CtzR+3kUeEOHigVW/mPZUd09OYK87McFN3dgiBJLIAbb3NGOEpT5/cDuiAPwxbg5BvfkWyHDGeliNyu8nj0gNhA5TXPJ1oNgeS8Yzz/L3Xg1PK+uBWXTIz4mstORafYk45DoJaZu9wbL5fGf8LA16r/rBUWnVfchO6Hwt3NlPnUBnmv7rWPtWI7PfEFgoWAuVpOkvzfTjDUxcXRqUA1nng2LX5ygAGBELM7ZTtjfNVtrYxDXckYhXOBC2iTyVYJ5+oSMMQG9uMeLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBf5iH04IB6LpL1AZHt/qQEG78BHFOYBu4nXeDYqywE=;
 b=ld/LaSYcsDZGRwlSwusWoQwE8L0Qs69KqzEyhUyXqHcGKaxV0E2p3nHftQKWq3Hf4y+SoI7i9Hx9OsdsGHtdPKd+u5IVA4xN8B77i5AsZ/9Khm953WS6Ol6L+SsXDx0rNlmurrHbFald/3JdVK9B+z6ck/S8hgIvv4puGcPTOKLUB7s70Jl2ZsZAmK0Q/7l0LNQ/gaZm0hzCsk1tNHOI5DX5DDMeMPYwQZGNjEUM3rSMCZ8OGiJlwFZMllkAtNIN59QatPZ/MqiHiqSZQ8rxb/zy2wlvzvEj+di5qj1B1VHNUFUr+i1BwppicaT3knDkzTpzNF4x1GgDnPmdJiu0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBf5iH04IB6LpL1AZHt/qQEG78BHFOYBu4nXeDYqywE=;
 b=Hc/8W3Bs13Yk7dFHmO2sKgxMCbWtrfVNJV8H52FJ5WVoSe8X+htDemzoKKfnSXP+BIJRRbrnn383tZYXqAq6uxPrzDMU4qi1m8EBORreST9JNtXrJUDmI71ZLBpF8RE0fjYa8xq9dWeBg7AjenBu71KKZgcYSY0b+wM19gRCEKw=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB6940.namprd03.prod.outlook.com (2603:10b6:510:16e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 17:28:06 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5746.028; Mon, 24 Oct 2022
 17:28:06 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Juergen Gross <jgross@suse.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "adi@kriegisch.at" <adi@kriegisch.at>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Thread-Topic: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Thread-Index: AQHY5S6guM11mZi1eU2dnhLTM/dNx64bMt2AgAJCJQCAAA9HgIAACC+AgAA85QCAAAg5gA==
Date:   Mon, 24 Oct 2022 17:28:05 +0000
Message-ID: <858a4288-46ac-d423-a529-b3b77b7fbc8a@citrix.com>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
 <30a056c8-071f-4259-3253-75e718af619d@suse.com>
 <Y1bEQMS5SNTbZO/3@infradead.org>
In-Reply-To: <Y1bEQMS5SNTbZO/3@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|PH0PR03MB6940:EE_
x-ms-office365-filtering-correlation-id: c8a01dec-0293-45f3-f9f8-08dab5e51cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LgeZPGJlxGQHvfhWPySeLJGQ8zUhipmqzsv49fJM5/u85It5KveC/pYOCANkWaJ23yZCXGyLd+HQraldxiYcz4QrVHrHkXn4w8ftsPSbkVoMlwwVzACdAwcwWLA6IcRp2ciMbDRWNwsCpGIifmGih6v+cSYGVqS3Evr01NM/GugNnKVlXrp91Hop7YnZjOyO90KRwFsS9QEo7MF40kxU6Li5jjTel0t2H2X8ispnYVH+w0Ayzwt96ASf09WVwoJjbSvArxY1Q2iW7KZm+FxgGC/6K6malADf5SkoSY2lm6cUypEdqGTgVeBvg+I/wcPFjMNgaCvuiHjTwdAHhAMDAww8GgFnEtGd8AQOXILcjeMFdYi2PuBP+/BO4S04fkS7k8FxIWkKp3pIU1CttCZ9H3JKopUc8SyWAy6pxhXspjHnbAgUPiR68+/PWFC2u8kwgiKtl1JPDxKC2ij6FWsvjJg3RFNiADrswQzRiP5u1+NJBETZziaIWrWvi+04bBqVwuPVWkSGFAJy6vH7qhzq2QtCHk1B752/krF9I6MB/kDhoxXvZHwB7UPtTfv8396UHxnDlLqHSZStgm1GSEq2fr1hAsRvrMB3AH+gXviZkVPqpizvGhWHb+FDkcRGlsG+1Nu99ViONZ9O2lNMqpC55FKv8dRVil6DdHKpE+fqomCmrByQ+XZtZDxc1NB4/NmJKWqOE58pfwuz2wtGQ9D7RXELbSr0RcBP2OO5P+aINoDHMnqrEz9BbW25G44QPp0BsNoYwUyfRPLdO8EdrdfyltFFssK9BlYQZDvWpHi86A2pNqZgKtJA+3JErqLHPAKu+djv1DUTIxv7yvJykvWB8QhIPaiGcShWtqTup2ZQRRsmhuCtLOAgKeuq6y6pZ9jr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(76116006)(31686004)(110136005)(54906003)(6506007)(66946007)(6512007)(53546011)(8936002)(2616005)(64756008)(66446008)(4326008)(2906002)(41300700001)(91956017)(7416002)(186003)(82960400001)(38070700005)(66556008)(66476007)(38100700002)(122000001)(26005)(8676002)(5660300002)(316002)(478600001)(71200400001)(6486002)(83380400001)(31696002)(36756003)(86362001)(42413004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkdtcGRINitiSDVwTUk4c1VxREpEMzZJVjE5bFlVMGR3WUpYOFlCQ3BJaC9D?=
 =?utf-8?B?Y29uaWk2Mjcva2N0VHR5c01zTU9RYk84ZDBQVVFQZTlzZktzTlZZV3EyaDgz?=
 =?utf-8?B?bWlMbEtGSnJKTkhqRTN5cWFYN0pJRlA3Yi9CN2xCUUNUSjB5K1liMGZWckd5?=
 =?utf-8?B?RFhNWm9lcGFjZU85dGlpN1lDdnM4aU9lYmtpRWdOZ2hsZXUwZjdqdkpOSndI?=
 =?utf-8?B?ZGNTNHZxOXZSQ1JQeTQzTVhyVStNVFJCWXJWT2dNdUo4L3ZpcmQrL0F6N0xl?=
 =?utf-8?B?SjJ6NWQ5dWF0SUhlb256cTlGbFp4cFBPbTRseXg0N0VZQTc3akw4WDJROVRp?=
 =?utf-8?B?cHJoYkhIRElDVWN2UXdGTm8zUHhtTXFkZkVpMENvOUFCQXFkRzZWWnlDQUNj?=
 =?utf-8?B?THlWWU1WT3VHNW15cTFRTUQ0bDRsM29MckdDL3kza1QvdHVoV1Z2QkhjVkQ3?=
 =?utf-8?B?RjlIa3VDZnU4MXBLa3I0VjZjeVlMMk1CN2l0WEIyNkx1dzhac1FacjA4WlNq?=
 =?utf-8?B?T3M5ZmtEZVk0bElQbTZPZWxLVG5xNlZydGpYbUxkZGZqSS8wc2RQWENuVWJR?=
 =?utf-8?B?dmp3d25qZHZSVUVBR05WN1VlbHlyT2F5RWljOWpxQ1hUbzVXL3d0U1ZKSmJq?=
 =?utf-8?B?L0RWUHdUMnAyR1NRSWpoVzllZVBGcjc5T2RxR1NGQlFJb09scVpMeitqN29W?=
 =?utf-8?B?elNPVHhuTDEwdlk2b0EySEtTb0dVWlNYQ1RCcXVWQ3ZJOC9XWmNFc2l4R3NH?=
 =?utf-8?B?QmpHT2dRalh3OWtzeThYYzRJUzdLYUU2T3d3dUExSXB5RjUxb0x5eUFQT1FT?=
 =?utf-8?B?L05yNExLWnQrZVlDUmdFWjlkVUxZRHFwNnoxT2s3Z0V4T3YrcHJaQjZEbzFn?=
 =?utf-8?B?dzBoVUl5aDJSOG1UWkpBOE5oQU9VLzliS2ZPK3dkTEJ5aE9MOXVuU1U3cnR2?=
 =?utf-8?B?UGVxOTZFM3JzbTNzUFBBNy9RK0RlRlJCQ3M5VHVpR2h2RHFxa0lncVdxVTN4?=
 =?utf-8?B?YzhIMUxGazVCYW9JRVNsd05sbFhpeERSMlZCelZwL0p4anFPVGFCRlB1UWJs?=
 =?utf-8?B?RTVQWlpSdHRNdVRjMWYwMUZOUWJOMEhmWWlKUVRmSTJwZlF5MDRPVUhldHNR?=
 =?utf-8?B?eGdUb0Rld2R6QmI4ZURZMTQxaW1XL1FwZm9CRE9TYmhQRStnRGhwNlRtYmFP?=
 =?utf-8?B?MmRYMFowc3Z0d1FzTVJxaGhtdmRKd1pqSndlajJ3bUNrQkVpemF4bkRGcU9M?=
 =?utf-8?B?QjFtTEdsTE9yb0R1eFdLVmEwbDEvRnRGU3NPU21QdExjMFA5ZkxJbGJZZmJL?=
 =?utf-8?B?cStzMjJITkZyemd0d3ZLZlhIS2wwRlAvMHBUUW91UE50alpLVDJzZFcwa0o4?=
 =?utf-8?B?TVU0eDI1Ym4wWmpoa00vNGZ2N05zSUtnOVdWUW9EWTRsWVhCWHZISnBrYm1S?=
 =?utf-8?B?UENzd2k3SENhVG95bnpGaW11K0xRMlQramxOSUEzb1MzVERiaUpFZ3lrZGVE?=
 =?utf-8?B?Q0t4MXB2STN3VGR3SzdxbmI2Z3dGbWNKR1VWaS9CRU5VSDRpUDZpZi81RnRJ?=
 =?utf-8?B?MGFHQlBsdlBydno1V0ZFby8vdGlYK3E3OVF4aWpxaGgvTkNJSktoRjA2M0Nt?=
 =?utf-8?B?aHBPY0p5SnlFZjU5bUw0Z3RTOEdNWEwvWERNQXlncFd0bDlUUk9UOGNpRHFj?=
 =?utf-8?B?UStaUUlrTVNWVk1TVkZUMTlEcllwUFRtSFhnanEwejYreFdRTURyVFB3dFhN?=
 =?utf-8?B?Q3NBUE5EZVZHckIzK0owK2FodjFSMFdZajdLZWx6alluQVJDMXhEYnZodGFy?=
 =?utf-8?B?RDlVc0tzdm9yM0R4R3NYeVFzTWJhMkRsdy9XQSt6dE9SS1VJUjJ0bGdBNmpq?=
 =?utf-8?B?djR5UGNQdGpGS1RaOWNMVmtVVkFBa2svMnhXVWMvM2Y3UmphblVVcDNiNFpT?=
 =?utf-8?B?UE81aWRxL2FnWWx6Qk1MMEtyMG44Yms5aW40aERWdzZzZ0YxVjVNdlU1MFZB?=
 =?utf-8?B?RmEvc0s2SFRFSEZEME1PL3NqcTJ4L2tSM1NDQUxEelFyL1VPR2hsOWpYVElL?=
 =?utf-8?B?MnoyZW9WSUpuR3JlNFNGVGhLdGsreUdGdVA4LzFFdHBPSllJSmgwNWtIRkRZ?=
 =?utf-8?Q?luWpc++N6E9VRgIqIvnJ4loC1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB3D38FAB1990F4AB62E657DC3966ED8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a01dec-0293-45f3-f9f8-08dab5e51cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 17:28:06.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lNqpXGdZlwzmrzjjxMlqv/faPeall/g9qnys8YflWeuHQqvBr/Yc5FqcUI7p8SJtno/Ct4AW5atwtRifkeGGVLNjgcysEdQ6t3AC/h8j1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6940
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMTAvMjAyMiAxNzo1OCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIE1vbiwg
T2N0IDI0LCAyMDIyIGF0IDAzOjIwOjQzUE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+
PiBEb20wIGlzIChub3JtYWxseSkgYSBQViBkb21haW4sIHNvIHRoZSBwaHlzaWNhbCBtZW1vcnkg
Y2FuIGJlIHN0aWxsIGFib3ZlDQo+PiA0IEdCIGV2ZW4gd2l0aCBkb20wX21lbSBzZXQgdG8gNEdC
Lg0KPiBXaGljaCBtZWFucyB0aGF0IHdlIG5lZWQgdG8gZW5zdXJlIHRoZSBETUEgb3BzIGZvciBY
ZW4tUFYgKHdoaWNoIGlzDQo+IGFsd2F5cyB4ZW4tc3dpb3RsYiBJIHRoaW5rPykgbmVlZCB0byBy
ZXR1cm4gRE1BX0JJVF9NQVNLKDY0KSBvciB3aGF0ZXZlcg0KPiBpcyB0aGUgaGlnaGVzdCBwb3Nz
aWJsZSBhZGRyZXNzLg0KDQpYZW4gdHJpZXMgdG8gYWxsb2NhdGUgbWVtb3J5IGZyb20gdGhlIHRv
cCBkb3duLCBpbiBvcmRlciB0byBrZWVwIHRoZSBsb3cNCm1lbW9yeSBmcmVlIGZvciBzcGVjaWFs
IHB1cnNlcy7CoCAoMzJiaXQgUFYgZ3Vlc3RzIHN0cmljdGx5IG5lZWQgdG8gbGl2ZQ0KYmVsb3cg
dGhlIDEyOEcgYm91bmRhcnkgaW4gaG9zdCBwaHlzaWNhbCBzcGFjZSBmb3IgQUJJIHJlYXNvbnMs
IGFuZA0KWGVuJ3Mgc3RydWN0IHZjcHUgbmVlZHMgdG8gYmUgYmVsb3cgdGhlIDRHIGJvdW5kYXJ5
IGZvciBjb21wYXRpYmlsaXR5DQp3aXRoIHNvbWUgcHJvY2Vzc29ycy4pDQoNClRoaXMgbWVhbnMg
dGhhdCBhIDY0Yml0IFBWIGRvbTAgZW5kcyB1cCBvY2N1cHlpbmcgdGhlIGhpZ2hlc3QgYWRkcmVz
c2VzDQppbiBSQU0uwqAgTmF0dXJhbGx5LCB0aGlzIGlzIGEgcHJvYmxlbSBmb3IgZGV2aWNlcyB3
aGljaCBjYW4ndCBkbyA2NGJpdCBETUEuDQoNClRoZSB4ZW4tc3dpb3RsYiBpcyBhIHJlZ2lvbiAo
ZGVmYXVsdCAxMjhNIGlpcmMpIHdoaWNoIGRvbTAgcmVxdWVzdHMgb2YNClhlbiBkdXJpbmcgc3Rh
cnR1cC7CoCBJdCBpcyBiZWxvdyB0aGUgNEcgYm91bmRhcnksIGFuZCBwaHlzaWNhbGx5DQpjb250
aWd1b3VzICh1bmxpa2UgbW9zdCBvZiB0aGUgcmVzdCBvZiBQViBndWVzdCBtZW1vcnkpLg0KDQpI
ZW5jZSBpdCdzIGEgc3VpdGFibGUgYm91bmNlIGJ1ZmZlciBmb3IgYW55IDMyLWJpdC1vbmx5IGRl
dmljZXMuDQoNCkkgZG9uJ3Qga25vdyBleGFjdGx5IGhvdyB0aGlzIHRyYW5zbGF0ZXMgdG8gTGlu
dXggaW50ZXJuYWxzLCBidXQgbW9zdA0KZGV2aWNlcyBhcmUgZmluZSBhbmQgaXQncyByb3V0aW5l
bHkgdGhlIG1wdDIvM3NhcyBkcml2ZXJzIHdoaWNoDQplbmNvdW50ZXIgcHJvYmxlbXMuwqAgSXQg
d291bGQgYmUgbG92ZWx5IGlmIHdlIGNvdWxkIGdldCB0byB0aGUgYm90dG9tIG9mDQp0aGlzIGZv
ciBvbmNlIGFuZCBmb3IgYWxsLg0KDQp+QW5kcmV3DQo=
