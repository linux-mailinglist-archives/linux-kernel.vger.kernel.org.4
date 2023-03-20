Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA3F6C19FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjCTPkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjCTPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:40:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46534037
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:31:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so48272720edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679326314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONCoqAuPFAdxcHJlJkmwpKMX/MPlR6FkYHZLYnTGWGA=;
        b=ZAG07fjd1pGdKzK6v1r6GnVVdTiwCGVdbZgvimV0oMBbMrtpEp7Vf5VtfChYznrOc6
         H0M5oKF/oqkK+eiujHnj4RkGkHe1EGUWGTj5spGvroIRSc0RunHN0DZeywnFEy+ELW3g
         I1IsObzaSbYO7aYSdtbhiiuZyLfr04luFU8Ju/hnMT9QRQjo3bnL3xU12gKF8bXKVocG
         wPSKeMuXRncMIA08YpSBxkh35gUR42GYCP/ZSehhvMNiZVSOhSd24vgR4AsLaeCwcD26
         mQChHP13oK+HLvVovVvuVvI/Re5PiAqBU2KoYz0eW9Tb3NAQLfevbE9pwLetC1J9bp4O
         FRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONCoqAuPFAdxcHJlJkmwpKMX/MPlR6FkYHZLYnTGWGA=;
        b=OIoE6vxXXnhOYLCNmfcMDgA1TwHGNNtpJlBsMpvDWgox9DIrFdKouU1TJH/pBcaR9t
         KHsMC5CAWPsxUSh6nbTEjPK9wEeaFFK377powSgwidW2q8crcMEDKPHrh9IODtajgM4w
         E3iDKHR4XOtcutpd100Cmt3Y+UU4MtHADMjHpcrgpzmXEuCqTMJw+m5q6SocUqrhFy+K
         aWpdEkmEI5S5ruzCT1iKNuSMKYbDjEBVTwO5gjKZDDI6ITKgU/X+I08hFn9Mv6sfrtjB
         LVlTY+carlUStZZvoj6QHx4ArmPI+h1EsFMspCSwatPwvdx+PIqe8AtP5UJbYPkdAw1q
         LztA==
X-Gm-Message-State: AO0yUKXocA10X88Mh5j2TM/awqSXHFE9wcPOaZYKRXm1WcsAwj/kvhKX
        i7D4JAmX7AuFVMDQEO+4vhNGLKyjRTMq1HXrKWyhyw==
X-Google-Smtp-Source: AK7set9zRda+HOBbyE1RH7U3Q5LdXAIFkGANo3ucDxxjiF5CtJ+awwn6fl76qqAqukfOF4oE95J6aFnk+XfPYhz4GPU=
X-Received: by 2002:a17:906:cf8d:b0:930:310:abef with SMTP id
 um13-20020a170906cf8d00b009300310abefmr4344539ejb.3.1679326313919; Mon, 20
 Mar 2023 08:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
In-Reply-To: <20230320005258.1428043-8-sashal@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 20 Mar 2023 15:31:42 +0000
Message-ID: <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, shuah@kernel.org,
        yhs@fb.com, eddyz87@gmail.com, sdf@google.com, error27@gmail.com,
        iii@linux.ibm.com, memxor@gmail.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:53=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> From: Lorenz Bauer <lorenz.bauer@isovalent.com>
>
> [ Upstream commit dfdd608c3b365f0fd49d7e13911ebcde06b9865b ]
>
> Add a regression test that ensures that a VAR pointing at a
> modifier which follows a PTR (or STRUCT or ARRAY) is resolved
> correctly by the datasec validator.
>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> Link: https://lore.kernel.org/r/20230306112138.155352-3-lmb@isovalent.com
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha,

Can you explain why this patch was selected? I'd prefer to not
backport the test, since it frequently leads to breakage when trying
to build selftests/bpf on stable kernels.

Thanks
Lorenz
