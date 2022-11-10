Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25747623A30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiKJDJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKJDJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:09:37 -0500
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F061D303
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:09:35 -0800 (PST)
Received: from localhost (003.mia.mailroute.net [127.0.0.1])
        by 003.mia.mailroute.net (Postfix) with ESMTP id 4N76JG1w4dz24hw4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:09:34 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([199.89.3.6])
        by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id Sg5bO76An8sZ for <linux-kernel@vger.kernel.org>;
        Thu, 10 Nov 2022 03:09:32 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 003.mia.mailroute.net (Postfix) with ESMTPS id 4N76JD101hz24hv0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:09:31 +0000 (UTC)
Received: by mail-pj1-f70.google.com with SMTP id om10-20020a17090b3a8a00b002108b078ab1so2550800pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AuiViQRfjQWppeuMf+SuKMxRs2Z0h2rUhwj+YwxMN+Q=;
        b=ZOzYNOyPUL86aMpUAd4XjGErMSbBUc0vDEIQhzMVYTWyFZUs7+uJvfXLDYDab3S30M
         pqEums169lSyyGP+0cSuKTJPAmqq9ZXE875Tr5bQo439GO8j56Wq3QRm96BtWfePsuh2
         qHxCAPCT+lYszZRA+8ZqUc0A7yB36GkHH619IYIAFTCelusuA74bw9OZ7GU++puzp3mU
         PmQ7eA5JIdcwxGSWTvf7A9RIne9I2gteQCBV+qm9XyjlLak5qDFiRtXhj54VvOj6t5Hc
         dcMmLuF/Ihc2ftQGchbIwVrmQFyvZAWUYdV3/ia14tTG4l4K8R05XwsyTsxkhFxdQIa3
         v0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuiViQRfjQWppeuMf+SuKMxRs2Z0h2rUhwj+YwxMN+Q=;
        b=hZXyM2ET+5U/OJA+1hwnO2QGrHd7T2yT/MqL2ZKE5Rg0BkIU5uCzjBsw8tuO/UqtQs
         4sTwT9eyI3bYG0cW7ZnxSeHPfaG0Uz0TuHz7fLcNT6bS0lg1CfmYa7TUUMVZ4b5KhoeO
         WGo5bVvgTGUqMS3sC2AsG4QKrab9gXhM8XxJp5cKltN9ATJ5uLKQo9FIqTCcaIgdHJ+G
         pEExItfjS6YZEcFj3lf+zr/DPYuIChO/p0QpL84RfuY8cJ4ItI39ReaK0+yoh1y8oWAF
         DibAwaHAP/EgFNSdnBpYn6xj2vkEVBinbATxk3T7ExVLK0N4RmlyORF87JGc8W1Gpiy3
         Fa4Q==
X-Gm-Message-State: ACrzQf3gl/Y8jJM/HPNeDGAvrGyqU2N9fI7kiBXvGjqtA2YdzvMciukg
        Emn7C9nGabeha8Kgqd5a3JGHz3g9KqRU72JEL6+1kPZSRF8D59n1zsdmHmLWXtE7JrPg+fJULWM
        To78o3OuxJEHRjbWpgGf2BTl5DB8i7IKmXK7jZOc1zw3/HjznZrgJfWc=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id y8-20020a1709029b8800b00188620d90fcmr33540713plp.61.1668049770059;
        Wed, 09 Nov 2022 19:09:30 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5MPTE7vJnNKQyRhDyXmGFH3IT7hkXHK7Q739qTyDGWXmwovs1ft2TUvAhGlVQjgAfn4MFVQBNYTTlImv+kXpo=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id
 y8-20020a1709029b8800b00188620d90fcmr33540683plp.61.1668049769748; Wed, 09
 Nov 2022 19:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20221107063807.81774-1-khuey@kylehuey.com> <CA+pv=HNPDvr_SV0f6RSBz2A3qBQQLBXaaxTPPT4FABQhwQwuHw@mail.gmail.com>
 <6d29eadd-69ef-343d-fcc8-b0432d604e92@intel.com>
In-Reply-To: <6d29eadd-69ef-343d-fcc8-b0432d604e92@intel.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Wed, 9 Nov 2022 22:09:18 -0500
Message-ID: <CA+pv=HMUmSBJcJnVOxpZecVJFO_oLC7Of+LVdJyTuu2zut_fgQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6] x86/fpu: Trying to fix writing PKRU through ptrace
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 3:52 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> Thomas had some strong opinions in the area, so I've been neglecting it.
>  I'll put it in my queue to take a look now, though.

Awesome, thanks.

-srw
