Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61436D288B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCaTOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCaTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:14:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCF022EB4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 407B9B831EB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 19:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E60BC433EF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680290047;
        bh=/CfZt4OxuWD1DSgb/0vFAV/hFLZFC/08ki8yZZJNyGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HDYTQoSJjAdKe4gL5JgY46rfh7x/dEe470GRbfoSawYRHwO7E+9Rn1lZF2waARMJ0
         XeIkTmESGJDmtvVo0wdcGjQVD80l9098Zo9KX7pHVG0wdbJlVHeyRLttvv1VfJVSj7
         kk+d5UUyl0WbvRvxw0Wp+KhpDeW6hD8TDwmlj+1iVd0RktH8yGGHW2/buL+yY78iux
         2+R+TGsP1lxjx7RLvgFPKN7SG3aukZXUI+DJDu0mbsMg4RABuF3SToYY6jH6Nc6XK/
         O0lI8mStDVJigdO1CX0NTNdfy3eyViTaN3kY3AsAVxituL0YMaq5nGo18oPNzxkfQH
         WkjmXIviL3pDg==
Received: by mail-pj1-f42.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso24392313pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:14:07 -0700 (PDT)
X-Gm-Message-State: AAQBX9feCF6VOXsWdz05vlloS+YMHnO+sGVmWEm063K8tKM0h5RnQVEc
        uIq4APrw5CGgsoJVskW+4WuvbFZF8PRx/KqRYHJxuA==
X-Google-Smtp-Source: AKy350aTSo3hL6GihtyDfEbY7KALV0nbI7oV3810z5Osa8s8LnAKd53t7j7zMzopdF/vN4/hqMoON66jprXPPl64qtg=
X-Received: by 2002:a17:903:1105:b0:1a2:8870:5ba2 with SMTP id
 n5-20020a170903110500b001a288705ba2mr2674034plh.10.1680290046470; Fri, 31 Mar
 2023 12:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org> <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
From:   Ross Zwisler <zwisler@kernel.org>
Date:   Fri, 31 Mar 2023 13:13:55 -0600
X-Gmail-Original-Message-ID: <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
Message-ID: <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:45=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
> Make sure that the .text section is not divided in multiple overlapping
> sections. This is not supported by kexec_file.

How does this interact with patch #1 from this series, which IIUC
allows us to handle the case where the .text section is split between
.text and .text.hot?  Do we still need that patch, but only for
non-x86 platforms?  Or do we need both, and this patch will need to be
replicated for other arches?
