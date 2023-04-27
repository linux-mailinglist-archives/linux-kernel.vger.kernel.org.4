Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965276F0481
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbjD0KwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbjD0Kv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:51:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72519AF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:51:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-505035e3368so14422044a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682592716; x=1685184716;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z55DYR9raqycVy/van6MrmuFs41/RmwWjRQ4dk90r2E=;
        b=Zb+pvCu5GW5C/9ekwWekRJtL9TliIp05T1feFxoOyweRG9PwS4TIT0LJzsVZltZhZm
         Ze6dh4lwTzzRNEk+mrwBoRVdoFO/NDU4B5A98OI4FL+nOVenlT8eHcWcaLKWNAlsx616
         ixFXDv4N7Nrd+rwN1lxhP2IzsW7ebTv4CKW5h+SQacLwMJVPG3rVL/23XumJ9JY0wtp5
         LXvI6wqQMKzDcZeN95wrPa/g/kbJ0lEnxuGjldurg91aujqSVidT83Ehy1GPSkAlTFpj
         yjjrRjbcH8FRC62nvIpZjQqdzBXXBN9622lxJOyJxiwHU7JOhci75AtmgN0Y6b2YTcU4
         facQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592716; x=1685184716;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z55DYR9raqycVy/van6MrmuFs41/RmwWjRQ4dk90r2E=;
        b=eDj7NhXsDhfA6ifsB5aAWdAJJJrE1o5nMWmSS99lTRMBBFaL7wqpQv38gezvzp6jaT
         um9qmVsbwWHNlC32xU4io0Yhlr9vXRfVpIAPKvD+sS3//niA6rYcqo8rXflJIaGPHi59
         wnx7cgHsaWBCPQCXNoXeh+jTHtFH1TjZCGiIJ+95Zt4IK8o1p0rq26kVioBTiaGhAe+K
         UjBnIvc0D+hQj+DnQzaQYd52zCTwXZbNqSaHjJRJhEJEt7aqG6KMSNLDDmnLne5MZE95
         CfD+Wxj6sea22vu0YHVOaF93RVa3XIqUWMuMZ3BTwsnvWS/47HEsB7EnPp/oxp7mWSZF
         IeJA==
X-Gm-Message-State: AC+VfDya5O0BJTOoRgd8hEmyJtzsmQoK98IN3YaF1BNSSpM5+M2iGqS9
        Ukmn5K/sdKZUz/luk7VCsdYoav8rfEPvxh4uS5y9s8vf4bg=
X-Google-Smtp-Source: ACHHUZ57tuzjf8jjPONsGFEDNoOpcPrxOIPAK6HmhQhxlM54hjiHMGM/f2zkMunYFnUKtjxfdQ0KejalhTidUnbyue8=
X-Received: by 2002:a50:ee98:0:b0:504:b511:1a39 with SMTP id
 f24-20020a50ee98000000b00504b5111a39mr1029890edr.12.1682592716412; Thu, 27
 Apr 2023 03:51:56 -0700 (PDT)
MIME-Version: 1.0
From:   Raj J Putari <jmaharaj2013@gmail.com>
Date:   Thu, 27 Apr 2023 03:51:45 -0700
Message-ID: <CADXzsigVPkgkx4vmaKnhGuMdjt_3w0Fo3eFqDNSwyoH9JCrRQw@mail.gmail.com>
Subject: using gpu's to accelerate the linux kernel
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is it possible?

id write it but im an amatuer and i dont have time to read the kernel
source and experiment, we're talking about nvidia and amd video cards
assisting in processing heavy data.

lets say youre compiling a kernel, you can write optimizations into
the kernel through a cuda module and offload cpu data directly to the
gpu using opencl or cuda or what amd supplies, i think gpus are
extremely diligent at processing data and i think theyre speedy, its
almost like buying a second cpu for your computer or device

you can try making module that speeds up the kernel or write it into
the kernel, or hopefully write it into the open source modules for amd
and nvidia

hope this helps everyone
