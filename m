Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0564E314
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLOV34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLOV3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:29:54 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D627B22;
        Thu, 15 Dec 2022 13:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZzyB8e5kkmqwPLtfyxEmXXlcTt2YzzikfBkoxJrH/N8=; b=Zl0XC+nj6wJcd2brZ4qDma88Rr
        bkpBKPHJYFlupv845lzeDvNyatM+cwB313t/l6RXcZujuBXlk/nTS0e8758iuVzpHmSFekjljiy8U
        7vpx+RPpfT62MQy3MOGmNJKAToDv2eHKUU0RnEQsOtcsOqa/8JAhFUtihCz4RK3ff+5K45K+wDD0/
        ymKY6fVCJmh7pojuY3wiHbPw1I9RVEfYyKDE2z/2wSa2yykDyn/FtZIqLHokoBMKLiYyzZrzcXpUK
        DMlmA4sp0xpUVayt0ehJB/6kPoxuPEyrWdPXCfBOC4O/VazzJLM4yJMrar0K14IyPphImb+dHPRti
        +CPUprdQ==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p5vnS-003ylO-If; Thu, 15 Dec 2022 22:29:43 +0100
Message-ID: <2aef3548-0565-3878-4226-ab6ca12d9eee@igalia.com>
Date:   Thu, 15 Dec 2022 18:29:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] kexec: Introduce paramters load_limit_reboot and
 load_limit_panic
To:     Ricardo Ribalda <ribalda@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
 <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 13:38, Ricardo Ribalda wrote:
> Add two parameter to specify how many times a kexec kernel can be loaded.
> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysfs, but only with a value
> smaller than the current one (except -1).
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---

Thanks for your patches Ricardo!

Small nit in the subject: s/paramters/parameters. Just observed that
after Joel's review anyway, so kudos to him heh

Cheers,


Guilherme
