Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DDB5EE861
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiI1VhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiI1VhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:37:01 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B993511
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:37:00 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131b7bb5077so2326054fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8OWmUn3+T5zXTPaC+bf/lvL+XUKnWGP4IeTHrEcXpWE=;
        b=DAdkaMwy6Nx8AURbnCII/HrGRywjeRMMs43hcDL+Maxwu0ZOzhIwHK+Gtz/gpvjnSf
         WhjzpzVpYYjVrKiPbnaylJVaKB9uYUnlPOkyCCAXZ5+ELgclwh5Ug0VSNdae7cwwlfjx
         SqhDO2Ux6nkXy00+0QG1PJND6cXxqp+LAErK7v1I4IU7pG5d6FnTdQLRofTmvVe8tPmS
         cJBPJOq+1qmeySCbEmzuvf8W63hr3Mhq6UdHAb+oMcy1F47MIvbkvWvSU7ijlaqmZhAq
         CfCyOkOGx3B1uyqlaNNCO7PvczvtcjsDjNruVBFYrcyv60c+cy9zk2GT3wlp1HdUjK0+
         tabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8OWmUn3+T5zXTPaC+bf/lvL+XUKnWGP4IeTHrEcXpWE=;
        b=lGm9LjEyfC52rKHnLgddj2M8pK8DQuvWlYdVEVMFjiFxxTCU0KYECp2CFWObf+qbRk
         VEchUA1wqVnZa+kAt5djfTVB9Ra7DxI7jdu8p3oUFQpDmuUrBq53PITOHjoH5Yhw6kcI
         5u9cJw3X5v7qgZsbLCuodtxo/HklIYY42AqpcNguOVXyip/PKXyx0pYsc5RzMs6NRfpO
         vti0WavRK/rfLh5t2PCw0/LEUx+LdUf3dmQFyUxb8zSn4clS8F7reBg/JGgMqx0Q7fqA
         6t8CUqsrgH+xPq7+jlBR351N88bYI58zAgURGj/LAgdlr1skmwIX3ZvMJMBrDBeGAgb0
         zPyA==
X-Gm-Message-State: ACrzQf1nwZD6aDrnZBZ+iolE+jXDb07W0sEMrjkIp0lnwmwu1VsBajdg
        UfOxrOj/91AuYEHjUYhedcdOQv2UwbeJbhhHeAySPQ==
X-Google-Smtp-Source: AMsMyM4LqskWTLvxoPVhDXyAtfbGtTpAFYGl2ctvyY6tM+2CE+l2S7WyCBcSIm5xfa9I2rCoag8cFpNzF25ep1laIus=
X-Received: by 2002:a05:6870:5250:b0:127:4360:a00b with SMTP id
 o16-20020a056870525000b001274360a00bmr6538854oai.13.1664401019207; Wed, 28
 Sep 2022 14:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220928213458.64089-1-colin.i.king@gmail.com>
In-Reply-To: <20220928213458.64089-1-colin.i.king@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 28 Sep 2022 14:36:48 -0700
Message-ID: <CALMp9eQJQaPbp+UrAYzwLXUGuMdOxOQVVJRs5bJOzjn02RM-_A@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix spelling mistake "begining" -> "beginning"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 2:35 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in an asset message. Fix it.

Nit: assert :-)
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
