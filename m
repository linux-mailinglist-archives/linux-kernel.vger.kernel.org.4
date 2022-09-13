Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D406A5B6B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIMK2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIMK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:28:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F605A3EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:28:02 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-015-236-229.89.15.236.pool.telefonica.de [89.15.236.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA0931EC063A;
        Tue, 13 Sep 2022 12:27:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663064876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NR8+qSGd70FyFZIqMDelCVg7QhrMj7ZzdfzeAllpKuA=;
        b=MsKDq8ftqSH7gvufJr2H6oMICQSJcCjWATXgH5uEHUEZ6rE1PKOf2dbMa/NDexiSVllcAb
        cmJNHgX4fgJR+40HQ2+8lGaQkDlRcJoNAtP6dnTNYk4+ZJZqw4IHKwaODwwFiYyXNzruCF
        IV0zYiQrz+n3IRSogF+31iMZPOlNn5Y=
Date:   Tue, 13 Sep 2022 10:27:53 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Manikandan Jagatheesan <mjagatheesan@vmware.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Kodeswaran Kumarasamy <kkumarasamy@vmware.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Peter Jonasson <pjonasson@vmware.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Rajender M <manir@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: Re: Performance Regression in Linux Kernel 5.19
In-Reply-To: <PH0PR05MB84483065597B17B361CBA9ABAF479@PH0PR05MB8448.namprd05.prod.outlook.com>
References: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com> <YxxCMSYaI/o3QH03@nazgul.tnic> <Yx8Q1L3jNAJxa84L@nazgul.tnic> <PH0PR05MB84483065597B17B361CBA9ABAF479@PH0PR05MB8448.namprd05.prod.outlook.com>
Message-ID: <66C9A8CD-C4FF-4E41-8F5A-FF58FE4F24E2@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 13, 2022 8:40:49 AM UTC, Manikandan Jagatheesan <mjagatheesan@=
vmware=2Ecom> wrote:
>Are there are any ongoing activities to optimize the performance?

What do you think is there to optimize here? Might wanna read my reply aga=
in=2E=2E=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
