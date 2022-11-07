Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD761FFC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiKGUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiKGUuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:50:05 -0500
Received: from 003.lax.mailroute.net (003.lax.mailroute.net [199.89.1.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E651EEDD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:50:04 -0800 (PST)
Received: from localhost (003.lax.mailroute.net [127.0.0.1])
        by 003.lax.mailroute.net (Postfix) with ESMTP id 4N5jzJ2BNSz1sppF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:50:04 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 003.lax.mailroute.net ([199.89.1.6])
        by localhost (003.lax [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id 2e9gzf9tMtWm for <linux-kernel@vger.kernel.org>;
        Mon,  7 Nov 2022 20:50:03 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 003.lax.mailroute.net (Postfix) with ESMTPS id 4N5jzF5QW4z1sppC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:50:01 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id r126-20020a632b84000000b004393806c06eso6745242pgr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7C2AzLoIXAOHTIa3Ey64y5Lcd9pKKsuRkuQWS8S5h84=;
        b=EAFy6Ne/R1g5VTzYbERV/rFcUG1RncvMunzz4ZfDLEkndNaa8881m/x/wOgeArPhb8
         J3+9RZPJ7DZCR0zR5GE5SKdmHmuXmSsNRV78mzdhuv158Vfa3dJupI7cGBZKBC9UnLhN
         npNSENOVtuPiCJGBaFz+6wvkF9cZXdQ1h6hY9v6AV7d6Ikyher73i7x6lf1qMvFJPskw
         kUmnYWKWvCLf9aSHHb2bIwwMpTKX2QV/+JnHWFN/VcmGCPZxhbrSj6vmGeeS09rzPsfZ
         KhWmZXtsDF0ASL4eEmRjZxzJ5IfT0A10PDkZuexcZmkmokRfjt5i19eYHEA8fO8NJHe5
         D+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7C2AzLoIXAOHTIa3Ey64y5Lcd9pKKsuRkuQWS8S5h84=;
        b=DHrU8WGZleqI+K19kvn1xfNcfPpwbHYyWX3eIL5IojtpGs+G+26mAEMjmTKdmPC+PZ
         mSIr9GiqIzHGdaIaT3iAYVbSom/tnb/YkSsei7MeNkysGvAdI4ueFbH6DK9/2HngacXb
         gTek3s+IdAAs40EufrmrvYHtVM+tlofU/N/6S/HJFdrfZYnHfAGj4+kRnus9en911YZ3
         lUsYne8glpj87KGr/f+5eFqlTGM9A/KIu1x+T4xX9JucTMUmkKWNu+8+Pno+7aLxW8GC
         rmlPVsTfYNu+hEorIatroj8l1c0QrXNT3CxsCz1kEr33wq1BvMJ5HCpfpAHZcYIpwo2N
         WmPw==
X-Gm-Message-State: ACrzQf0KjiU5ZpwEeL1Nudb/SJl42xouN0DFNqyD/BPPHJaJwu7SxQhC
        DO2usiED8ZaEibhG0gTDt5k1OLSiUyIjFdZvG5aKaxxWheouZvq3ll+SLONe6JV/yFbAkQxCN8l
        qH8LHKHk7sIRkQ9w7OdrXGTKWXrOxS7b5mQhepOyc74Ia1eJaWgRjIYo=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id y8-20020a1709029b8800b00188620d90fcmr22192411plp.61.1667854200193;
        Mon, 07 Nov 2022 12:50:00 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7xWEFMd05xK8hyJabZq53YX527qoS3pncq2Cf2MdeoKWmeTkDLEGqQ331usKklxWYzqf9H26GDfE4z++eeLjE=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id
 y8-20020a1709029b8800b00188620d90fcmr22192381plp.61.1667854199868; Mon, 07
 Nov 2022 12:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20221107063807.81774-1-khuey@kylehuey.com>
In-Reply-To: <20221107063807.81774-1-khuey@kylehuey.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Mon, 7 Nov 2022 15:49:48 -0500
Message-ID: <CA+pv=HNPDvr_SV0f6RSBz2A3qBQQLBXaaxTPPT4FABQhwQwuHw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6] x86/fpu: Trying to fix writing PKRU through ptrace
To:     Kyle Huey <me@kylehuey.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

On Mon, Nov 7, 2022 at 1:38 AM Kyle Huey <me@kylehuey.com> wrote:
> I've been trying since July to get this regression that was introduced in
> 5.14 fixed. This is my third time submitting this version of the patch in the
> last two months. Both prior submissions have not received any comments from
> (nor have they been applied by) the x86 maintainers. I don't really know
> what else to do at this point beyond "complain to the management" as it
> were.
>
> I appreciate anything you can do to unjam things here.

Maintainers: is there any reason why this hasn't been applied, or
received comments? I'm confused and a bit worried.

-srw
