Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4555F0C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiI3NXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiI3NXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:23:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58C18B488;
        Fri, 30 Sep 2022 06:23:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a26so9022059ejc.4;
        Fri, 30 Sep 2022 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=5vv4f1wFsPeVTBqSvv3Pe0mWx/1Owam/ACCctyPHW/Q=;
        b=eCn3IbAukucRF/15f32+vWS+pxun8qbZwVmDjAFXkzU7uzSm5fnjbTgMDZD9jepF7e
         rE4GWHleYMnomV7KRNdT6ESrFX8DRIdYUQUuiQTbPWxEx32cLLsDGmYJDbLrXZcAK7Yx
         B6E8v1Ss+afOp36BHLrzCqc925hIFz/ZU0TGGEx8uSZard2wowpSCeW4pkrTUooxORno
         oIRe7Y5OtBqsyoMPdbz5ZQ2vCzzZ9LwQh8W03vXqy0L3nE4cTGIVFDFdvxamOIXvhvmP
         l5WzZki9Oh6aTEcI8vNELDZ3ocQ+dN+IDq13wLgF6s6kbFuC3V9SsNVYgSvKwx0IT0p/
         C64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5vv4f1wFsPeVTBqSvv3Pe0mWx/1Owam/ACCctyPHW/Q=;
        b=p92MGrlCDapA3Adl+CSHVRd9fqHS31rXkAUoQG/aQM8sLG+Lely229gzbm1htNPb8c
         +5iwGKh6fv7d6jrVEgbW00JAacQXcZbOZRgIC+uxcYgoD2Xjk6m5PNtUq57sDSV/o4hs
         f4NGtT4ssbsGo12qu2hdl0mL+b0Btn5NW6rkeWmZBXKKW512i/XISJFa5y7YGt3QMXPC
         efJ5elHlPSO5RgNQrx25xAAZ0x1AnDU+ZSr9zSr2b2jDJ3AVUejEODbJ0mpY6XOuUj+5
         zHBoo8XX2hEie914fL2cq9JiKe2gk2hjapMTMxVzJGc2wB0AriBn9GHNXi/J3afwvnv/
         4g+A==
X-Gm-Message-State: ACrzQf3No1zHomDwoxVbZ/TGZkG60dRPn5w6xd5/BaxlEOTWdBU7l0k/
        P0lt/hXIspjGR+tmqAJOJx7rli7y0Ek=
X-Google-Smtp-Source: AMsMyM4TuRnXQtY9Vnex+NlpGXckNWxiiCimXEPwwdGTaB/As9nRY/Q7deCdFHtO0xELAQ0ljjlSRA==
X-Received: by 2002:a17:907:25cc:b0:77b:a6c7:6d2b with SMTP id ae12-20020a17090725cc00b0077ba6c76d2bmr6502273ejc.148.1664544222909;
        Fri, 30 Sep 2022 06:23:42 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id la3-20020a170907780300b00781dbdb292asm1165779ejc.155.2022.09.30.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 06:23:42 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:23:40 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [mic:next 4/9] fs/open.c:191: undefined reference to
 `security_file_truncate'
Message-ID: <Yzbt3D0Wji9DGW0A@nuc>
References: <202209301029.GH8uhPky-lkp@intel.com>
 <48bb80b5-3bc0-7072-c02d-d62a02c75bf3@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48bb80b5-3bc0-7072-c02d-d62a02c75bf3@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:02:00AM +0200, Mickaël Salaün wrote:
> This build error arises when CONFIG_SECURITY_PATH is disabled. Indeed,
> security_file_truncate() is only defined in security/security.c for such
> option.
>
> I have pushed the (rebased) fix in my next branch. FYI, you can keep the
> current Acked-by.

Thank you, I'll merge that fix into v7 of the truncate patch set. I'll
try to send v7 to the list soon, so that you can have a look at the
newest version of the patch set.

> 
> Original patch:
> https://lore.kernel.org/all/20220908195805.128252-2-gnoack3000@gmail.com/
> 
> 
> On 30/09/2022 04:57, kernel test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git next
> > head:   054fdc359167ae7c17a5fb47c0edbf5cb4b737b0
> > commit: 0052f28b7cba97cefa48623ef087d1c1cc06078f [4/9] security: create file_truncate hook from path_truncate hook
> > config: x86_64-rhel-8.3-func
> > compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> > reproduce (this is a W=1 build):
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?id=0052f28b7cba97cefa48623ef087d1c1cc06078f
> >          git remote add mic git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
> >          git fetch --no-tags mic next
> >          git checkout 0052f28b7cba97cefa48623ef087d1c1cc06078f
> >          # save the config file
> >          mkdir build_dir && cp config build_dir/.config
> >          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >     ld: fs/open.o: in function `do_sys_ftruncate':
> > > > fs/open.c:191: undefined reference to `security_file_truncate'
> >     ld: fs/namei.o: in function `handle_truncate':
> > > > fs/namei.c:3214: undefined reference to `security_file_truncate'
> > 
> > 
> > vim +191 fs/open.c
> > 
> >     155	
> >     156	long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
> >     157	{
> >     158		struct inode *inode;
> >     159		struct dentry *dentry;
> >     160		struct fd f;
> >     161		int error;
> >     162	
> >     163		error = -EINVAL;
> >     164		if (length < 0)
> >     165			goto out;
> >     166		error = -EBADF;
> >     167		f = fdget(fd);
> >     168		if (!f.file)
> >     169			goto out;
> >     170	
> >     171		/* explicitly opened as large or we are on 64-bit box */
> >     172		if (f.file->f_flags & O_LARGEFILE)
> >     173			small = 0;
> >     174	
> >     175		dentry = f.file->f_path.dentry;
> >     176		inode = dentry->d_inode;
> >     177		error = -EINVAL;
> >     178		if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
> >     179			goto out_putf;
> >     180	
> >     181		error = -EINVAL;
> >     182		/* Cannot ftruncate over 2^31 bytes without large file support */
> >     183		if (small && length > MAX_NON_LFS)
> >     184			goto out_putf;
> >     185	
> >     186		error = -EPERM;
> >     187		/* Check IS_APPEND on real upper inode */
> >     188		if (IS_APPEND(file_inode(f.file)))
> >     189			goto out_putf;
> >     190		sb_start_write(inode->i_sb);
> >   > 191		error = security_file_truncate(f.file);
> >     192		if (!error)
> >     193			error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
> >     194					    ATTR_MTIME | ATTR_CTIME, f.file);
> >     195		sb_end_write(inode->i_sb);
> >     196	out_putf:
> >     197		fdput(f);
> >     198	out:
> >     199		return error;
> >     200	}
> >     201	
> > 

-- 
