Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0C6094C0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJWQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJWQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:34:48 -0400
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:103:465::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8F22B26;
        Sun, 23 Oct 2022 09:34:42 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [91.198.250.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4MwP1J3cHLz9sZZ;
        Sun, 23 Oct 2022 18:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1666542868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTlByM7X0a7TGoECHCtYIhOyKZuzkGCKgtZ/y3W75rs=;
        b=oUU7bQEEbPDGCE41tFrPcWAUZbdxkQV2PhLsTAGe++RlpUCQr4jKPG93Bb4fZzo2Sm3ivk
        oTuOaKO/JCpG0y3r6gz6bARdwtGmgHjuI+RPi6lYYk6zKMTbevzHoNSMb7Decz9rKsxAwm
        fC9EcHMnoO8uOOj0UB6tVjVFTedCppszC6yq0h7e7AddcXJ3SPCMBj3hYdOcbvhvf2GFyl
        68izRtfS4ChwUskCcmHnMVMahGYbsxM76rPxjsZsy9zo5afIdTcDMbTh4sqEhlfsRhdWUW
        alkG20STwbjZs4RwuPLLbn1kpu3M8Af9FXRKkRB0oIj5UJRUCDEuLHyKK6tvSQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Oct 2022 18:34:27 +0200
Message-Id: <CNTG53X3S1UV.22Z2IAXN79SJA@ancom>
Cc:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Henrik Rydberg" <rydberg@bitmath.org>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] Input: add driver for Himax hx83112b touchscreen
 devices
From:   "Job Noorman" <job@noorman.info>
To:     "Jeff LaBundy" <jeff@labundy.com>
References: <20221017100409.189293-1-job@noorman.info>
 <20221017100409.189293-3-job@noorman.info> <Y1NwxQ5DbusemrFc@nixie71>
In-Reply-To: <Y1NwxQ5DbusemrFc@nixie71>
X-Rspamd-Queue-Id: 4MwP1J3cHLz9sZZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sat Oct 22, 2022 at 6:25 AM CEST, Jeff LaBundy wrote:
> Hi Job,
>
> Great work so far, just a few remaining comments.

Thanks a lot for your second round of comments! Everything has been
addressed in v5.

Best regards,
Job
