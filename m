Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5BB73A727
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFVRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFVRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:24:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20EB199B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:24:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-989d03eae11so329729266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687454643; x=1690046643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7NlwJWhRn9vHCeh97jNIwU31z0pZlGYxYgOuGVCJzI=;
        b=dvJcLE41E36YYhtUQ7PHGfwyAcquKBKIJIlyikv838sTlsaqDoPFbYGMCezfpxq/x7
         0FebxD1wbfRTwgHRwX5iwd5wHAutXUzl+ON0b36Cue9o+0FSeeIwgSEgjLK8iEqaTM53
         0hphiRi+FdMFlv9VOsnV97CfvqiH9Hk5obMLsmY5nMQcY7HbA+hdCM+6oJnlQgrRht53
         E392BMbVXiXyO10U0h9+ewm3Nu4sFjNkdLPB3cNFcV/u/E/BXBRKtipXoeNTQsaQ7Bwo
         Ze/XO/y41b8Hl4M3NrITrqybEZNrXZ+qBPlSbjJFTy5VYnvoHAcMtph9vE13v3SFFsJA
         C1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454643; x=1690046643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7NlwJWhRn9vHCeh97jNIwU31z0pZlGYxYgOuGVCJzI=;
        b=BRpDbnfoIdHgeWgKeCtdoI5Lj61HrupRflNlBuY0IZCySQKlZ74gE5Ov2e/4PdkCRQ
         +PN7P4mejZqhFStY4oPxHWGFwCWrlIq+tEJyCdEI31ttjG1MDbDMmoqisYL3w8PuiMhB
         HVjGu/H30eLMAcKqyIiuXrDD5UHVX70bS0lR7C1RKn0GcjPwv2L+FsfJcqQB9+akwsHz
         YQIZs/44W8KiDSB0xD2b14gLyaJSVKZnWwWFKRbnK4FBN+dMb3slDEJW9Vv8qpKWOdl6
         NgJTA3PojFbsolQ9NNVWRxUvJ9OR4r3jWznPyLSxQmCEB5DbNMzKmitaFnNwZ02io7Gf
         6/tQ==
X-Gm-Message-State: AC+VfDx8LE62clYYDzhMvE6c6fFjfbDRzpCEZZ+yKqFrAZg5nO2SX+xw
        vnC/BMo8r7vZrsNS47R7ExSrog==
X-Google-Smtp-Source: ACHHUZ7P3Qy5Z4td/nDkOO2K8MDAWad9Trpj9+x3B2xC+pr7mISzhOGHYtMtsPwiPVOnhaT68CrZhQ==
X-Received: by 2002:a17:906:4793:b0:965:ff38:2fbb with SMTP id cw19-20020a170906479300b00965ff382fbbmr18956070ejc.1.1687454643258;
        Thu, 22 Jun 2023 10:24:03 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id lu4-20020a170906fac400b009889c4bd8absm4911712ejb.216.2023.06.22.10.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 10:24:02 -0700 (PDT)
Date:   Thu, 22 Jun 2023 19:23:56 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Message-ID: <20230622-4af59422f118ea634836d351@orel>
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-d6da578719f8af903d6746ef@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621-d6da578719f8af903d6746ef@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:19:50PM +0200, Andrew Jones wrote:
> On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
...
> > +Hardware description
> > +--------------------
> > +
> > +The firmware can pass either a devicetree or ACPI tables to the RISC-V kernel.
> > +
> > +The devicetree is either passed directly to the kernel from the previous stage
> > +using the `$a1` register, or when booting with UEFI, it can be passed using the
> > +EFI configuration table.
> > +
> > +The ACPI tables are passed to the kernel using the EFI configuration table. In
> > +this case, a tiny devicetree is still created by the EFI stub. Please refer to
> > +"EFI stub and devicetree" tree section below for details about this devicetree.
>                              ^ redundant 'tree' here
>

Can whoever applies this drop this 'tree' I pointed while applying?

Thanks,
drew
