Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04770FC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjEXRFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjEXRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:04:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34DD123
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:04:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-97000a039b2so203468766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684947894; x=1687539894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX7TwOTtxI9078iXGRe1v6WXZvE2EIyaYMEVVHOjuhQ=;
        b=QB74L0/jxXd7y6nW3o9xkHAJIGRnmghtu93J4jDvwNvITeAIoQ1Kd1rRdiYr0EsKlO
         +aIzASoolJ7V5hvYVZHGh+d1/19LfKg+NewxKOmVGDjN3vIpHFdFVLQt1Qluu2Rpm/3+
         aK0A+P4xTNZfXzKSq4eTMQ/cB3Tjxhif9bPIY00bqC8CLJS6c8BmMFPgpsLjOCk6gm3S
         YbtFgwOiKDh7RgQ5jbPAbs1P6nZNf4zntXtiORXMtYxAbsEKieiIoAZibgKcmbS2wjv1
         4zhipa+jS2pTh/jdOn/KCsGN/3lPwStUz3dDOJwPkipAeFah+0fTPiKkrFDGPvm/BHyl
         7Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947894; x=1687539894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX7TwOTtxI9078iXGRe1v6WXZvE2EIyaYMEVVHOjuhQ=;
        b=Q4uMyPz6lmjupZrIQH78hR1eKxBbl6oK2mLsF8CovciW4VHR196onzHjZfUqOTa9A9
         69FO/LsSUEbh5XbgYpdMCsSUtVwctTpc9AxaIuHictqOVwVf+mq1HJCkGjXOr4WR8qXt
         NHHfySD6+17nWjnVgbxgya3S8qeKjk57otaS4RwYAps+XHa2C9ORIQlo19ZCNaRgZx4H
         W6twT0wHFZ6Lkm1KocjyK3UFHU8x3tWFmGe+uFTGPhKznuToL/N0qO6BrymZJWhELF6a
         Md6kSlsZ6gI/UI0GCxzY5ZCOJ5CzNAtuXQZv3JvaabXpRXo8Yrdl6Qc4tyoy7nkVGyfi
         +w6Q==
X-Gm-Message-State: AC+VfDzLeTZSq+azhXns/Ch78YnQEzs9VOf1eu+gbmmkWAjssYsba/t/
        JRvdWLQK23anl91t7c94Z+ETBJ+CtoihRJhkS/PFTg==
X-Google-Smtp-Source: ACHHUZ4aecbcum+oSXCnZ+4TJGsowymNKbx5UWCjquYoSEqmkz10v6iOSfhb3hZe59JPC3irVPSk8/T05oYKdYrnw0g=
X-Received: by 2002:a17:907:8a10:b0:96a:d916:cb2f with SMTP id
 sc16-20020a1709078a1000b0096ad916cb2fmr19835435ejc.36.1684947894084; Wed, 24
 May 2023 10:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com> <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh> <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
 <2023052435-xbox-dislike-0ab2@gregkh>
In-Reply-To: <2023052435-xbox-dislike-0ab2@gregkh>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 24 May 2023 18:04:43 +0100
Message-ID: <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 5:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Great, any specific commits that fix this issue would be appreciated to
> be pointed at so we can apply them.

The problem was introduced by commit f4b8c0710ab6 ("selftests/bpf: Add
verifier test for release_reference()") in your tree. Seems like
fixup_map_ringbuf was introduced in upstream commit 4237e9f4a962
("selftests/bpf: Add verifier test for PTR_TO_MEM spill") but that
wasn't backported.

To restate my original question: how can we avoid breaking BPF
selftests? From personal experience this happens somewhat regularly.

Best
Lorenz
