Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E6B6811E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjA3ORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbjA3OQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:16:51 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2050.outbound.protection.outlook.com [40.92.53.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44743D095;
        Mon, 30 Jan 2023 06:16:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTMqYQtZaJ6J7u70pQRH+v1jQezjaZtrNhxI8wAk37a8VDByp3NMNWwxV12QKG2INrg7SYTbIRWzN52PSO34yWNgDozuEkE05iAkpG4stUJl/hRiBN6gBCZVHm/VelyyBbDSIFAoofbPCooK69pGq3/yDfTWT2q9uJTYJTj7Kw4WjJk9BaDkhfVnBRAazxasStsTnZ5m/z5cAZ39c35IXStXBSPN9+BP46M8xUzAj1pAjI49mfDipOQXakCdmhk8hjY9xEK7lpwQmJtABbd2e3o8XjYV8x5Ea7ERJWTYsupVxb3rHCHjDwnEcyCPfCZVGqYf3SeVgsY4LePM4iGWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzpPyPfEXniWkVtvhKJlmojzKDdIDw5q0GYvzOkQSaQ=;
 b=MEh+8IQT+zMLTQrXyYg/ZN6xTbL7Lay95AFcSCkaL9OgngtPw24yVbt6sasHE7Q3IU89ugs4gvtJWvT/RuyyYnEMciDpwdnmeycDxYs8fn3d7t7QFvSAwsciHiqSjCl+Xdyxzvdn0cp6PS21CQ9dYdmHQk+CleDWv4PKJ+QOU9RuNxOl6oQMb4e+VQAkINv5QUSgB1FLSZ2Smlcyyzbl3Avq09erCKhUBPnNgJIZ/aZ3SnRhzrk/94NLisaNNK7lphbp/qBrbG8KdBKYR5PqPC/ecSGvJEUptQyjvXTzA6Jl6fnBrDPop7ozStHjQSmrAp+XZB/B8ilEHH+JOT2r5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzpPyPfEXniWkVtvhKJlmojzKDdIDw5q0GYvzOkQSaQ=;
 b=jlco/IMEA74eCKaCtKgsZgo1cGK1GjfNIR4Mt6m6h9DWbRdkkRReOzE+yrNsoqnOLc2lLx6dm+vaGp/VHC9J2k3RAX2+KHox/UClV+xFpk7r1u4ZCbPwg6E8wZ2Q410sD2hbPSf9nGdVuj3t0k/CJ6hmVkXcJdYCNwfxoRjjg6M/nibd5UvvSxRjjL9wdhqAUdfIOJRm9G8cb5i3n0ovypiJjTee0jFeUR2I9WuhpldzjUDM/bkmF9mK1A+PD+4SHoLFxMnTutkbyoIrtZF1/TvnoNwyuJUlN8ADathIjGEwsk5n7pgj+5/Mz4PoC4RSFx4Z/8JehK6TIE0QTAMerA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYWP286MB2420.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 14:16:42 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::82ce:8498:c0e9:4760]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::82ce:8498:c0e9:4760%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 14:16:42 +0000
Date:   Mon, 30 Jan 2023 22:16:37 +0800
From:   Dawei Li <set_pte_at@outlook.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linkinjeon@kernel.org, sfrench@samba.org, tom@talpey.com,
        hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ksmbd: replace rwlock with rcu for concurrenct
 access on conn list
Message-ID: <TYCP286MB23230E29CC81F5C0590C59C9CAD39@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
 <TYCP286MB23235FDD8102162698EF3154CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <Y9dEZ5IgfwpZNlVm@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9dEZ5IgfwpZNlVm@google.com>
X-TMN:  [LV7WQ88WmJdLUoLKVWToCPQ5WOs0JIgw]
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230130141637.GA53949@wendao-VirtualBox>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYWP286MB2420:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2aa354-3084-4703-de15-08db02cc9c2d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlvTYXz6GOXl0PygYbp1nLeWD59THtqRcxQOeeNapKwtyjeVRw0oKLB1hppXmkIRqE5xE1r/JWysWrYJc5dbnRW+nSJskj3oioJNW15/oDt6Wl+dKSQ4XfAGpxlU/e3koS0O+93UGPZHzVa0PKGaD0nvOoqrDMA3DXc4nwt4kPYRe0ndIwUmjE1j8NsL5KQILIhxn7LCmDwm5zdRPW4iEhyamMeUcEBwr9o4TPyL9YkqCcVdgo28tfJkeyh9PzCrhgBb3ZIhKeXLbEPpGwoBWNKWxQQZ1oSQK7fXK9U6wJMdG7aAex9AZwaCr15OXjb4ZFB3iYnDzO4g1ns+rn9pXYfr/EIVftWO6mGTp08md1lVgILCIaztmKVgDClvgJYm5eyjzcmYxATpQCsNBbxgZdd472ZyynJlT+KIJX+4PQFbCRfnhzbob4O+hcJDDsMwwoqDldIZPzI5EU6OEcfX0urwlDipvTOTv0P0n56aE8W7Y7hzFQAavWIJmLM4wL/ucsDTzH/K8T0TQi0umujztFLBVDKiKqfxuDEmoJLraB/2m+dN+SgcnQehwd9P0wKtqyL8EyX1Q54s7VRcvbQiwBi40tw1khDD7vcvzWX6dsxdjdvuBwXuOOSK5qi2mKQt9AqdJBhxmd2UAve5t0bn5g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5HKLHLgTAdMfWGDDH1gjyXC5XQF7npTlwaWeB32lto+4lRB5voyIafJpwnE?=
 =?us-ascii?Q?r57UN4e44srWoDZjnhse7Rad0l1hbCNYy6PuZn6qEcBItrFCAr5DFhKbi7+/?=
 =?us-ascii?Q?74cTAVF8d2Ydd9kNmX3m5ih1FtmjNh6djGwtK5lZS+NekcgReHt+2/jKiO78?=
 =?us-ascii?Q?C7G5qDhJZSwHkyFWKDCXabs+TRWE7dx3kA7Eb3LKrsrJqKfystlGlTNEH/Rm?=
 =?us-ascii?Q?cuRN4Xh4SaX1kQSI2pB2gHoK8NKU3KzN0CW3aJKhVDIWme8KuYpvFfMGQjYw?=
 =?us-ascii?Q?ZiRxGg+aENr1VkB0FQyygpqxynuGPxCDKsdm/8iKgNGds1MojiWAJ+2xwUqE?=
 =?us-ascii?Q?WkbGP7/wVT55E8uZ2Vxf6rbMOHiSsLCsCo5xGF5WRj/6hI3ljitvMckRJ55K?=
 =?us-ascii?Q?b31ElMiuYND0Q/XfMB6O1iXhe5bZI/6u2Juw0uRCQIWB4tXlKPVZE1HZUtLb?=
 =?us-ascii?Q?OvS/ACZDe6u4guyc/n/qxg67nXMU4JxI1OpJf5M2VBBjaZFPwJceV+S8YwWj?=
 =?us-ascii?Q?S2X/AESuEHKDR5tGy1MF4rJx+P09UR/6knMT2JjWnwVKHEFJ5q9e0Be9lxiX?=
 =?us-ascii?Q?NFRLoOTGC+a4FRNIqFHwtLSfj8h117mLLlaDKIrQbfcwug2Mt43yEIcKikVi?=
 =?us-ascii?Q?eMouKGdU01P5EYGZLbQwJ023z47G9uuzHt5A+DEBqKxDDylCiZV+Dvy5epug?=
 =?us-ascii?Q?QZcB9kqnKbMZPHpXSh/g9kHHsqL266xmaCnOHAEqkT+YkcRMgkOQbZ3JcXRB?=
 =?us-ascii?Q?ti4lrJyWYeMOdBovr64XDmpr/DNvpZu22Bx4mThEnaeZwoxkL8qWqH2VWpwQ?=
 =?us-ascii?Q?G4cm7aTj9i+N78msnveQIlJlLBV8EuoRTBLe/DtiDtBob7pN9EA/ac5dn+Mc?=
 =?us-ascii?Q?pLSdozWOsywyKpz+0fOdJsv9www4SdlG3/Bdf07z9X08JKBIDA3Z+j9jE8E6?=
 =?us-ascii?Q?wbxqE9lGL3EhDue1c4zzsSVVrLf6alJNhigvSXULG5UugKp9O6x9DS8q2sCx?=
 =?us-ascii?Q?Hy4D3wR1YaPdjiPCgKFG3x785ethKYzq3R5eieZvtk/Vz2fWR7G0YT7R/dL3?=
 =?us-ascii?Q?XX3JwbEvYGnRdkBIWjaq7SuqmGp4waHw8oU+e3e10iUjl4b8nWw/bEGM+tch?=
 =?us-ascii?Q?Yz2KLhJMArHQOVyUEgnXfFbTDcq8lyKg3XgsMQ8MWv1emnaDI8BRuGMh+LA9?=
 =?us-ascii?Q?0GHwQbF+m1dI0GKnpZZyQrj5GrnfM/3uOez3X/cH0v/qiJmx6grCCVGNDX9q?=
 =?us-ascii?Q?yYiqkHQoW7CwYhA2NDyjISIIeL01XMiZxvPpSy2V5w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2aa354-3084-4703-de15-08db02cc9c2d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 14:16:42.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thanks for reviewing,

On Mon, Jan 30, 2023 at 01:15:35PM +0900, Sergey Senozhatsky wrote:
> On (23/01/15 18:32), Dawei Li wrote:
> > 
> >  void ksmbd_conn_free(struct ksmbd_conn *conn)
> >  {
> > -	write_lock(&conn_list_lock);
> > -	list_del(&conn->conns_list);
> > -	write_unlock(&conn_list_lock);
> > +	spin_lock(&conn_list_lock);
> > +	list_del_rcu(&conn->conns_list);
> > +	spin_unlock(&conn_list_lock);
        synchronize_rcu(); 
> >  
> >  	xa_destroy(&conn->sessions);
> >  	kvfree(conn->request_buf);
> 
> From a quick look this does not seem like a correct RCU usage. E.g.
> where do you wait for grace periods and synchronize readers/writers?

Nice catch, I totally mess it up. Thanks!

At first glance, I assume synchronize_rcu() will do the job if sleeping
is OK?

Steve, Namjae,
Please drop this buggy patch from ksmbd-for-next.

Thanks,
     Dawei
