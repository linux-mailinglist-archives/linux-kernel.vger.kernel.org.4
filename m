Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB673D128
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFYNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFYNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:25:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D171AD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:25:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d9850ef09so190949a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687699541; x=1690291541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfr3fFdPwwOJDAwc+hpqDVMfaS0p8xTBietG2xF0ewE=;
        b=O1xdGbyyriNjiEMtyFFQCm62vqvuLD+Rzxf/PDBDHFoqfvi24Iu+WI47Tk2LPt8tsg
         0Wvx+a8RX1lKdLstgsvHa4sPhL+jxWkYwPzO4bNvCdCVIS5/9d9zIevTw5d1716p7IAc
         8DkE0JRrifmiNhfrVOly5R9w6YzDhVf7sILGMT0sNPYYdSBWdScd+lipNNpaFkLQ6sjI
         CC/MOatleu2/x8VPJmwHVZ5ukHBNvHDeh6nUl/KjmPxWOqsG/GCu527TRhwzaVjsIYkp
         RCGsv2aqDenlbIKHW/AlHsX38W/f8tCMjk/45/4SmUj4D8lqt0eN0gfWqXMcreOxdz6F
         goEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687699541; x=1690291541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfr3fFdPwwOJDAwc+hpqDVMfaS0p8xTBietG2xF0ewE=;
        b=YFEMblIIuSf0PU7BRhmxVj4VLk+B1MHsT/zNuXjwEZLF54g4dop7LgPVNL09zeMOuc
         xZek9UN833M7ftcmu+zpBRoh+rAJITo5xiQA7QsH5AkbgIEImk6m5Z9TPbvtzomwmXsj
         vwfSlxgQZxUw3U1rGBAkPr1XuUOTyCu2q5cNQ2srjkjaegSjRwEndHEiee3iTUEB8ZeF
         KAlD44s92mntw8WoS3j2/K+N0yQQBUAyUpPKNvajRl7wBgmpPoU7+JC9RApWZynaZyJS
         GuX0mFn5rlcjMkMK2SO8GHclYcTeCHJ81xLifIMjGrC/5kDk0oenixSXUaFN/14vaE7x
         1wNQ==
X-Gm-Message-State: AC+VfDwnmhw26ICD/ETu08Y5GloItm/yfBlzzrFnp7TtgLoJu8TVJNxA
        bVs/rVh6I9DRIQDj8IzIyas=
X-Google-Smtp-Source: ACHHUZ4s5/Bew1hssf6d4HbKOBt6opSjcrL5siQiUhQFCwqi15VcOB5StbFx9iKGmV+H8lqGJh8TrA==
X-Received: by 2002:aa7:cb0c:0:b0:514:8fdd:fc41 with SMTP id s12-20020aa7cb0c000000b005148fddfc41mr16701825edt.15.1687699540636;
        Sun, 25 Jun 2023 06:25:40 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402001100b0051a53d7b160sm1757643edu.80.2023.06.25.06.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 06:25:39 -0700 (PDT)
Message-ID: <0b22e328-40e1-54d7-367c-96059a3fef7c@gmail.com>
Date:   Sun, 25 Jun 2023 15:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [dm-devel] [PATCH v2 3/4] dm ioctl: Allow userspace to suppress
 uevent generation
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20230624230950.2272-1-demi@invisiblethingslab.com>
 <20230624230950.2272-4-demi@invisiblethingslab.com>
Content-Language: en-US
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20230624230950.2272-4-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 01:09, Demi Marie Obenour wrote:
> Userspace can use this to avoid spamming udev with events that udev
> should ignore.

Well, does it also mean that udev will not create /dev/disk/by-* symlinks
(as response to the change udev event followed by internal udev blkid scan)?

If it is a private device, that is ok. But for a visible device I think
that it breaks some assumptions in userspace (presence of symlinks mentioned
above etc).

So, what is the exact use for this patch?

Milan



> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>   drivers/md/dm-core.h          |  2 +
>   drivers/md/dm-ioctl.c         | 71 ++++++++++++++++++-----------------
>   drivers/md/dm.c               |  5 ++-
>   include/linux/device-mapper.h |  2 +-
>   include/uapi/linux/dm-ioctl.h | 14 +++++--
>   5 files changed, 54 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index 0d93661f88d306e0d0aa3a1ac085880a8b63d9d6..5a4acdbf119f9b3f9a1c60de36d23f0658449701 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -115,6 +115,8 @@ struct mapped_device {
>   
>   	/* for blk-mq request-based DM support */
>   	bool init_tio_pdu:1;
> +	/* If set, do not emit any uevents. */
> +	bool disable_uevents:1;
>   	struct blk_mq_tag_set *tag_set;
>   
>   	struct dm_stats stats;
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 7abaeec33f1884d4588e8563fb02e9ea1a6782c8..7eab9a8c77ff3286346a1c44581d3b6370a731eb 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -821,6 +821,11 @@ static struct dm_table *dm_get_live_or_inactive_table(struct mapped_device *md,
>   		dm_get_inactive_table(md, srcu_idx) : dm_get_live_table(md, srcu_idx);
>   }
>   
> +static inline bool sloppy_checks(const struct dm_ioctl *param)
> +{
> +	return param->version[0] < DM_VERSION_MAJOR_STRICT;
> +}
> +
>   /*
>    * Fills in a dm_ioctl structure, ready for sending back to
>    * userland.
> @@ -879,7 +884,7 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
>   		dm_put_live_table(md, srcu_idx);
>   	}
>   
> -	if (param->version[0] >= DM_VERSION_MAJOR_STRICT)
> +	if (!sloppy_checks(param))
>   		dm_set_diskseq(param, disk->diskseq);
>   }
>   
> @@ -895,7 +900,7 @@ static int dev_create(struct file *filp, struct dm_ioctl *param, size_t param_si
>   	if (param->flags & DM_PERSISTENT_DEV_FLAG)
>   		m = MINOR(huge_decode_dev(param->dev));
>   
> -	r = dm_create(m, &md);
> +	r = dm_create(m, &md, param->flags & DM_DISABLE_UEVENTS_FLAG);
>   	if (r)
>   		return r;
>   
> @@ -1463,11 +1468,6 @@ static int next_target(struct dm_target_spec *last, uint32_t next, const char *e
>   	return 0;
>   }
>   
> -static inline bool sloppy_checks(const struct dm_ioctl *param)
> -{
> -	return param->version[0] < DM_VERSION_MAJOR_STRICT;
> -}
> -
>   static bool no_non_nul_after_nul(const char *untrusted_str, size_t size,
>   				 unsigned int cmd, const char *msg)
>   {
> @@ -1939,64 +1939,67 @@ static int target_message(struct file *filp, struct dm_ioctl *param, size_t para
>    * Implementation of open/close/ioctl on the special char device.
>    *---------------------------------------------------------------
>    */
> -static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags, uint32_t *supported_flags)
> +static ioctl_fn lookup_ioctl(unsigned int cmd, bool strict, int *ioctl_flags,
> +			     uint32_t *supported_flags)
>   {
>   	static const struct {
>   		int cmd;
>   		int flags;
>   		ioctl_fn fn;
>   		uint32_t supported_flags;
> +		uint32_t strict_flags;
>   	} _ioctls[] = {
>   		/* Macro to make the structure initializers somewhat readable */
> -#define I(cmd, flags, fn, supported_flags) ((typeof(_ioctls[0])) {				\
> +#define I(cmd, flags, fn, supported_flags, strict_flags) ((typeof(_ioctls[0])) {		\
>   	(cmd),											\
>   	(flags),										\
>   	(fn),											\
>   	/*
>   	 * Supported flags in sloppy mode must not include anything in DM_STRICT_ONLY_FLAGS.
> -	 * Use BUILD_BUG_ON_ZERO to check for that.  Currently there are no strict-only flags
> -	 * defined.
> +	 * Use BUILD_BUG_ON_ZERO to check for that.
>   	 */											\
>   	(supported_flags) | BUILD_BUG_ON_ZERO((supported_flags) & DM_STRICT_ONLY_FLAGS),	\
> +	(strict_flags) | (supported_flags) |							\
> +	 BUILD_BUG_ON_ZERO((supported_flags) & (strict_flags)),					\
>   })
> -		I(DM_VERSION_CMD, 0, NULL, 0), /* version is dealt with elsewhere */
> +		I(DM_VERSION_CMD, 0, NULL, 0, 0), /* version is dealt with elsewhere */
>   		I(DM_REMOVE_ALL_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT,
> -		  remove_all, DM_DEFERRED_REMOVE),
> -		I(DM_LIST_DEVICES_CMD, 0, list_devices, DM_UUID_FLAG),
> +		  remove_all, DM_DEFERRED_REMOVE, 0),
> +		I(DM_LIST_DEVICES_CMD, 0, list_devices, DM_UUID_FLAG, 0),
>   		I(DM_DEV_CREATE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT,
> -		  dev_create, DM_PERSISTENT_DEV_FLAG),
> +		  dev_create, DM_PERSISTENT_DEV_FLAG, DM_DISABLE_UEVENTS_FLAG),
>   		I(DM_DEV_REMOVE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT,
> -		  dev_remove, DM_DEFERRED_REMOVE),
> +		  dev_remove, DM_DEFERRED_REMOVE, 0),
>   		I(DM_DEV_RENAME_CMD, IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, dev_rename,
> -		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_UUID_FLAG),
> +		  DM_QUERY_INACTIVE_TABLE_FLAG | DM_UUID_FLAG, 0),
>   		I(DM_DEV_SUSPEND_CMD, IOCTL_FLAGS_NO_PARAMS, dev_suspend,
> -		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_SUSPEND_FLAG | DM_SKIP_LOCKFS_FLAG |
> -		 DM_NOFLUSH_FLAG),
> +		  DM_QUERY_INACTIVE_TABLE_FLAG | DM_SUSPEND_FLAG |
> +		  DM_SKIP_LOCKFS_FLAG | DM_NOFLUSH_FLAG, 0),
>   		I(DM_DEV_STATUS_CMD, IOCTL_FLAGS_NO_PARAMS, dev_status,
> -		  DM_QUERY_INACTIVE_TABLE_FLAG),
> +		  DM_QUERY_INACTIVE_TABLE_FLAG, 0),
>   		I(DM_DEV_WAIT_CMD, IOCTL_FLAGS_TAKES_EVENT_NR, dev_wait,
> -		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG),
> -		I(DM_TABLE_LOAD_CMD, 0, table_load, DM_QUERY_INACTIVE_TABLE_FLAG |
> -		  DM_READONLY_FLAG),
> +		  DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG, 0),
> +		I(DM_TABLE_LOAD_CMD, 0, table_load,
> +		  DM_QUERY_INACTIVE_TABLE_FLAG | DM_READONLY_FLAG, 0),
>   		I(DM_TABLE_CLEAR_CMD, IOCTL_FLAGS_NO_PARAMS, table_clear,
> -		  DM_QUERY_INACTIVE_TABLE_FLAG),
> -		I(DM_TABLE_DEPS_CMD, 0, table_deps, DM_QUERY_INACTIVE_TABLE_FLAG),
> +		  DM_QUERY_INACTIVE_TABLE_FLAG, 0),
> +		I(DM_TABLE_DEPS_CMD, 0, table_deps, DM_QUERY_INACTIVE_TABLE_FLAG, 0),
>   		I(DM_TABLE_STATUS_CMD, 0, table_status,
> -		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG),
> +		 DM_QUERY_INACTIVE_TABLE_FLAG | DM_STATUS_TABLE_FLAG | DM_NOFLUSH_FLAG, 0),
>   
> -		I(DM_LIST_VERSIONS_CMD, 0, list_versions, 0),
> +		I(DM_LIST_VERSIONS_CMD, 0, list_versions, 0, 0),
>   
> -		I(DM_TARGET_MSG_CMD, 0, target_message, DM_QUERY_INACTIVE_TABLE_FLAG),
> -		I(DM_DEV_SET_GEOMETRY_CMD, 0, dev_set_geometry, 0),
> -		I(DM_DEV_ARM_POLL_CMD, IOCTL_FLAGS_NO_PARAMS, dev_arm_poll, 0),
> -		I(DM_GET_TARGET_VERSION_CMD, 0, get_target_version, 0),
> +		I(DM_TARGET_MSG_CMD, 0, target_message, DM_QUERY_INACTIVE_TABLE_FLAG, 0),
> +		I(DM_DEV_SET_GEOMETRY_CMD, 0, dev_set_geometry, 0, 0),
> +		I(DM_DEV_ARM_POLL_CMD, IOCTL_FLAGS_NO_PARAMS, dev_arm_poll, 0, 0),
> +		I(DM_GET_TARGET_VERSION_CMD, 0, get_target_version, 0, 0),
>   	};
>   
>   	if (unlikely(cmd >= ARRAY_SIZE(_ioctls)))
>   		return NULL;
>   
>   	cmd = array_index_nospec(cmd, ARRAY_SIZE(_ioctls));
> -	*supported_flags = _ioctls[cmd].supported_flags;
> +	*supported_flags = strict ? _ioctls[cmd].strict_flags : _ioctls[cmd].supported_flags;
>   	*ioctl_flags = _ioctls[cmd].flags;
>   	return _ioctls[cmd].fn;
>   }
> @@ -2260,7 +2263,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
>   	if (cmd == DM_VERSION_CMD)
>   		return 0;
>   
> -	fn = lookup_ioctl(cmd, &ioctl_flags, &supported_flags);
> +	fn = lookup_ioctl(cmd, !sloppy_checks(&param_kernel), &ioctl_flags, &supported_flags);
>   	if (!fn) {
>   		DMERR("dm_ctl_ioctl: unknown command 0x%x", command);
>   		return -ENOTTY;
> @@ -2480,7 +2483,7 @@ int __init dm_early_create(struct dm_ioctl *dmi,
>   		m = MINOR(huge_decode_dev(dmi->dev));
>   
>   	/* alloc dm device */
> -	r = dm_create(m, &md);
> +	r = dm_create(m, &md, false);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index ea1671c39ba131ab2e49b93289d1094cda5cfb25..b7817b4aea52033afeeea9f2b93b9215de682e9c 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2281,13 +2281,14 @@ static struct dm_table *__unbind(struct mapped_device *md)
>   /*
>    * Constructor for a new device.
>    */
> -int dm_create(int minor, struct mapped_device **result)
> +int dm_create(int minor, struct mapped_device **result, bool disable_uevents)
>   {
>   	struct mapped_device *md;
>   
>   	md = alloc_dev(minor);
>   	if (!md)
>   		return -ENXIO;
> +	md->disable_uevents = disable_uevents;
>   
>   	dm_ima_reset_data(md);
>   
> @@ -3005,6 +3006,8 @@ int dm_kobject_uevent(struct mapped_device *md, enum kobject_action action,
>   	char udev_cookie[DM_COOKIE_LENGTH];
>   	char *envp[3] = { NULL, NULL, NULL };
>   	char **envpp = envp;
> +	if (md->disable_uevents)
> +		return 0;
>   	if (cookie) {
>   		snprintf(udev_cookie, DM_COOKIE_LENGTH, "%s=%u",
>   			 DM_COOKIE_ENV_VAR_NAME, cookie);
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 69d0435c7ebb0d7b712e2b8bf32d9ba34c54e09e..2be940c2c6f42ed8e13b97ea8b07d0895566f3e2 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -461,7 +461,7 @@ void dm_consume_args(struct dm_arg_set *as, unsigned int num_args);
>    * DM_ANY_MINOR chooses the next available minor number.
>    */
>   #define DM_ANY_MINOR (-1)
> -int dm_create(int minor, struct mapped_device **md);
> +int dm_create(int minor, struct mapped_device **md, bool disable_uevents);
>   
>   /*
>    * Reference counting for md.
> diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
> index 1d33109aece2ff9854e752066baa96fdf7d85857..b338a4f9a299acda9430995d63fbb490e70c8cd8 100644
> --- a/include/uapi/linux/dm-ioctl.h
> +++ b/include/uapi/linux/dm-ioctl.h
> @@ -369,8 +369,16 @@ enum {
>   #define DM_BUFFER_FULL_FLAG	(1 << 8) /* Out */
>   
>   /*
> - * This flag is now ignored if DM_VERSION_MAJOR is used, and causes
> - * -EINVAL if DM_VERSION_MAJOR_STRICT is used.
> + * This flag is only recognized when DM_VERSION_MAJOR_STRICT is used.
> + * It tells the kernel to not generate any uevents for the newly-created
> + * device.  Using it outside of DM_DEV_CREATE results in -EINVAL.  When
> + * DM_VERSION_MAJOR is used this flag is ignored.
> + */
> +#define DM_DISABLE_UEVENTS_FLAG	(1 << 9) /* In */
> +
> +/*
> + * This flag is now ignored if DM_VERSION_MAJOR is used.  When
> + * DM_VERSION_MAJOR_STRICT is used it is an alias for DM_DISABLE_UEVENT_FLAG.
>    */
>   #define DM_SKIP_BDGET_FLAG	(1 << 9) /* In */
>   
> @@ -439,8 +447,6 @@ enum {
>   
>   /*
>    * If DM_VERSION_MAJOR is used, these flags are ignored by the kernel.
> - * If DM_VERSION_MAJOR_STRICT is used, these flags are reserved and
> - * must be zeroed.
>    */
>   #define DM_STRICT_ONLY_FLAGS					\
>   	(DM_ACTIVE_PRESENT_FLAG | DM_INACTIVE_PRESENT_FLAG |	\

